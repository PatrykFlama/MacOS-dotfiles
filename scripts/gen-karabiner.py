#!/usr/bin/env python3
"""Generate Karabiner-Elements rules for this setup.

Run automatically on every `drs` (home-manager activation, modules/home/karabiner.nix)
with the per-host choices from flake.nix, so the rules always match the selected
window manager / keyboard. Only the rules (and, on first run, the keyboard type) are
written; anything else Karabiner or its GUI stores in karabiner.json is kept.

Usage:
  gen-karabiner.py --window-manager aerospace|none --keyboard iso|ansi
                   [--aerospace-config PATH] --out ~/.config/karabiner/karabiner.json
"""
import argparse
import json
import os
import re
import sys

ap = argparse.ArgumentParser()
ap.add_argument("--window-manager", required=True)
ap.add_argument("--keyboard", required=True, choices=["iso", "ansi"])
ap.add_argument("--aerospace-config")
ap.add_argument("--out", required=True)
args = ap.parse_args()

# Our scripts (scripts/default.nix) live in the per-user Nix profile.
BIN = "/etc/profiles/per-user/$USER/bin"


def launcher(key, shift, cmd):
    """Left ⌥ (+⇧) + key runs a shell command (via /bin/sh)."""
    mods = ["left_option"] + (["shift"] if shift else [])
    return {"type": "basic",
            "from": {"key_code": key, "modifiers": {"mandatory": mods}},
            "to": [{"shell_command": cmd}]}


rules = []

# --- Always: app launchers. They don't depend on the window manager. -------------
# Terminals open via ghostty-window (new window in the running Ghostty, not a new
# Ghostty process per window like `open -na Ghostty`).
rules.append({
    "description": "Left Option launchers (terminal, Finder, yazi, cheatsheet)",
    "manipulators": [
        launcher("return_or_enter", False, f"{BIN}/ghostty-window"),
        launcher("f", False, "open ~"),
        launcher("f", True, f"{BIN}/ghostty-window 'zsh -lic yazi'"),
        launcher("slash", True, f"{BIN}/ghostty-window --float --title Keybindings "
                                "\"zsh -lic 'glow -p \\\"\\$DOTFILES/docs/keybindings.md\\\"'\""),
    ],
})

# --- Always: left ⌥Space -> ⌘Space (whichever launcher owns it: Raycast/Spotlight).
# Left Option only: right Option + Space happens while typing Polish ("ą ") and must
# keep typing a (non-breaking) space.
rules.append({
    "description": "Left Option + Space -> Command + Space (launcher)",
    "manipulators": [{
        "type": "basic",
        "from": {"key_code": "spacebar", "modifiers": {"mandatory": ["left_option"]}},
        "to": [{"key_code": "spacebar", "modifiers": ["left_command"]}],
    }],
})

# --- ISO keyboards: the key between left Shift and Z becomes a second left Shift
# (ISO's left Shift is short). On Apple ISO keyboards that key reports
# grave_accent_and_tilde (checked in Karabiner-EventViewer); the top-left key
# (non_us_backslash) is untouched and still types ` and ~.
if args.keyboard == "iso":
    rules.append({
        "description": "ISO: key next to left Shift -> left Shift",
        "manipulators": [{
            "type": "basic",
            "from": {"key_code": "grave_accent_and_tilde", "modifiers": {"optional": ["any"]}},
            "to": [{"key_code": "left_shift"}],
        }],
    })

# --- Window-manager specific rules. -------------------------------------------------
if args.window_manager == "aerospace":
    # AeroSpace bindings are ctrl-alt-*; left ⌥ + those keys -> ⌃⌥ + key, so in
    # practice the modifier is left ⌥ while right ⌥ keeps typing Polish letters.
    if not args.aerospace_config:
        sys.exit("--aerospace-config is required for --window-manager aerospace")
    names = {"enter": "return_or_enter", "minus": "hyphen", "equal": "equal_sign",
             "slash": "slash", "comma": "comma", "semicolon": "semicolon", "tab": "tab"}
    keys = []
    for line in open(args.aerospace_config):
        m = re.match(r"ctrl-alt-(?:shift-)?([a-z0-9]+)\s*=", line)
        if not m:
            continue
        k = m.group(1)
        if k in ("left", "right", "up", "down"):
            continue  # keep ⌥+arrows = word jump
        k = names.get(k, k)
        if len(k) > 1 and k not in names.values():
            sys.exit(f"unmapped key {k}")
        if k not in keys:
            keys.append(k)
    # Appended last: Karabiner uses the first matching rule, and this one also
    # matches shift (e.g. ⌥⇧/ must open the cheatsheet, not ⌃⌥⇧/).
    rules.append({
        "description": "Left Option + AeroSpace keys -> Ctrl+Option (right Option stays for Polish letters)",
        "manipulators": [{
            "type": "basic",
            "from": {"key_code": k, "modifiers": {"mandatory": ["left_option"], "optional": ["shift"]}},
            "to": [{"key_code": k, "modifiers": ["left_control", "left_option"]}],
        } for k in keys],
    })
elif args.window_manager != "none":
    sys.exit(f"unknown window manager {args.window_manager!r} (add its rules here)")

# --- Write, keeping everything else Karabiner stores. -------------------------------
try:
    cfg = json.load(open(args.out))
except (FileNotFoundError, json.JSONDecodeError):
    cfg = {"profiles": [{"name": "Default", "selected": True}]}
profile = next((p for p in cfg["profiles"] if p.get("selected")), cfg["profiles"][0])
profile.setdefault("virtual_hid_keyboard", {}).setdefault("keyboard_type_v2", args.keyboard)
profile.setdefault("complex_modifications", {})["rules"] = rules

os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
tmp = args.out + ".tmp"
with open(tmp, "w") as f:
    json.dump(cfg, f, indent=4, ensure_ascii=False)
os.replace(tmp, args.out)  # atomic: Karabiner never sees a half-written file
print(f"karabiner: {len(rules)} rules ({args.window_manager}, {args.keyboard})")
