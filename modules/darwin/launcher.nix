# App launcher on ⌘Space (and left ⌥Space via Karabiner): Raycast or Spotlight.
# Chosen per machine with `launcher = "raycast" | "spotlight"` in flake.nix, then `drs`.
#
#   raycast:   installs Raycast and turns Spotlight's ⌘Space shortcut off
#              (set Raycast's own hotkey to ⌘Space once, in its settings).
#   spotlight: turns Spotlight's ⌘Space shortcut back on and quits Raycast if it's running.
#              Raycast stays installed (Homebrew cleanup is "none"); to stop it starting at
#              login, untick "Launch at login" in Raycast or `brew uninstall --cask raycast`.
{
  lib,
  user,
  launcher,
  ...
}:
let
  raycast = launcher == "raycast";
  # Spotlight's "Show Spotlight search" shortcut (symbolic hotkey 64): ⌘Space.
  # `-dict-add` merges just this entry, so other shortcuts set in System Settings stay.
  spotlightShortcut = enabled: ''
    sudo -u ${user} defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
      '<dict><key>enabled</key><${if enabled then "true" else "false"}/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'
    sudo -u ${user} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
in
{
  assertions = [
    {
      assertion = lib.elem launcher [
        "raycast"
        "spotlight"
      ];
      message = ''launcher must be "raycast" or "spotlight" (got "${launcher}")'';
    }
  ];

  homebrew.casks = lib.optional raycast "raycast";

  system.activationScripts.postActivation.text =
    if raycast then
      spotlightShortcut false
    else
      spotlightShortcut true
      + ''
        sudo -u ${user} pkill -x Raycast || true
      '';
}
