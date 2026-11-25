# Our keymap: change the shortcuts of apps' menu items – macOS's own "App Shortcuts"
# mechanism (System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts), declared
# here instead of clicked. The new shortcuts show up in the apps' menus.
#
#   keymap.<bundle id>."<menu item title>" = "<shortcut>";
#   keymap.NSGlobalDomain."<title>"        = … ;   # same title in every app
#
# Shortcut: modifiers + key joined by "+", e.g. "cmd+h", "cmd+shift+h", "ctrl+alt+x";
# "none" = no shortcut. Modifiers: cmd, alt (= opt), ctrl, shift.
#
# Notes:
# - Titles must match the menu item exactly, in the system language (English here).
#   Find them in the app's menus; a wrong title silently does nothing.
# - Apps read this when they start: quit and reopen an app after `drs`.
# - This owns NSUserKeyEquivalents for the listed apps: App Shortcuts added for them in
#   System Settings are replaced on `drs` – add them here instead.
# - Only menu items can be changed. System-wide shortcuts (Spotlight, screenshots, …) are
#   macOS "symbolic hotkeys" – see launcher.nix for how those are handled.
# - Find an app's bundle id: osascript -e 'id of app "Name"'
{ lib, ... }:
let
  keymap = {
    # ⌘H = History, like Ctrl+H on Linux/Windows (macOS default: ⌘Y). Hiding the app
    # loses its shortcut (still in the app menu).
    "com.google.Chrome" = {
      "Show Full History" = "cmd+h";
      "Hide Google Chrome" = "none";
    };
    "net.librewolf.librewolf" = {
      "Show All History" = "cmd+h"; # default ⌘⇧H
      "Hide LibreWolf" = "none";
    };
  };

  modifierSymbols = {
    cmd = "@";
    alt = "~";
    opt = "~";
    ctrl = "^";
    shift = "$";
  };

  # "cmd+shift+h" -> "@$h" (NSUserKeyEquivalents format); "none" -> "\0" (no shortcut).
  toKeyEquivalent =
    shortcut:
    if shortcut == "none" then
      "\\0"
    else
      let
        parts = lib.splitString "+" shortcut;
        modifiers = lib.init parts;
        key = lib.last parts;
      in
      lib.concatMapStrings (
        m: modifierSymbols.${m} or (throw "keymap: unknown modifier \"${m}\" in \"${shortcut}\"")
      ) modifiers
      + key;
in
{
  system.defaults.CustomUserPreferences = lib.mapAttrs (_app: items: {
    NSUserKeyEquivalents = lib.mapAttrs (_title: toKeyEquivalent) items;
  }) keymap;
}
