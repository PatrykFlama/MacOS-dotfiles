#!/bin/bash
# SwiftBar plugin: AeroSpace workspaces in the macOS menu bar.
#   Menu bar: workspaces that have windows (+ the focused one), e.g.  1  [2]  4
#             (current one marked according to STYLE below).
#   Dropdown: each workspace with its apps; click to switch.
# Refreshed instantly by AeroSpace (exec-on-workspace-change / on-focus-changed in
# config/aerospace/aerospace.toml), every 30 s as a fallback. Hidden while tiling is off.
#
# <swiftbar.title>AeroSpace workspaces</swiftbar.title>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>

aerospace=/opt/homebrew/bin/aerospace

# How the current workspace is marked: brackets → 1  [2]  4
#                                     bold     → 1  𝟐  4   (Unicode bold digits)
#                                     both     → 1  [𝟐]  4
STYLE=brackets

bold() { # bold <text>: map 0-9 to Unicode mathematical bold digits
  local out="" ch i
  local digits=(𝟎 𝟏 𝟐 𝟑 𝟒 𝟓 𝟔 𝟕 𝟖 𝟗)
  for ((i = 0; i < ${#1}; i++)); do
    ch=${1:i:1}
    if [[ $ch =~ [0-9] ]]; then out+=${digits[ch]}; else out+=$ch; fi
  done
  echo "$out"
}

glyph() { # glyph <workspace> <focused?>
  local ws=$1
  [[ $2 == 1 ]] || { echo "$ws"; return; }
  case $STYLE in
    bold) bold "$ws" ;;
    both) echo "[$(bold "$ws")]" ;;
    *) echo "[$ws]" ;;
  esac
}

if ! focused=$("$aerospace" list-workspaces --focused 2>/dev/null); then
  echo "⊘"
  echo "---"
  echo "AeroSpace is not running"
  exit 0
fi

# Occupied workspaces plus the focused one (it may be empty), numeric order.
workspaces=$({
  "$aerospace" list-workspaces --monitor all --empty no
  echo "$focused"
} | sort -u | sort -n)

title=""
while IFS= read -r ws; do
  [[ -z $ws ]] && continue
  is_focused=0
  [[ $ws == "$focused" ]] && is_focused=1
  title+="$(glyph "$ws" "$is_focused")  "
done <<<"$workspaces"
echo "${title%  }"

echo "---"
while IFS= read -r ws; do
  [[ -z $ws ]] && continue
  apps=$("$aerospace" list-windows --workspace "$ws" --format '%{app-name}' 2>/dev/null |
    tr -d '|' | sort -u | paste -sd ',' - | sed 's/,/, /g')
  [[ -z $apps ]] && apps="empty"
  checked=""
  [[ $ws == "$focused" ]] && checked=" checked=true"
  echo "$ws  —  $apps | bash=$aerospace param1=workspace param2=$ws terminal=false refresh=true$checked"
done <<<"$workspaces"
