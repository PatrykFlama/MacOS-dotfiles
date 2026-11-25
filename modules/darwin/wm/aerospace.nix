# AeroSpace (i3-style tiling) and everything that only exists because of it:
#   AeroSpace itself, SwipeAeroSpace (3-finger swipes -> workspaces), SwiftBar
#   (workspace indicator in the menu bar, plugin in config/swiftbar), JankyBorders
#   (focused-window border) and the macOS settings AeroSpace recommends.
# Its configs (config/aerospace, config/swipeaerospace) are linked by
# modules/home/dotfiles.nix; its Karabiner keys come from scripts/gen-karabiner.py.
#
# When another window manager (or "none") is selected, the apps are quit and
# uninstalled on `drs` – just dropping them from the Homebrew list wouldn't remove them
# (cleanup = "none"), and they'd start again at login. Switching back reinstalls them.
{
  lib,
  user,
  dotfilesDir,
  windowManager,
  ...
}:
let
  enabled = windowManager == "aerospace";

  # Homebrew cask name -> process name (for quitting before uninstall).
  apps = {
    aerospace = "AeroSpace";
    swipeaerospace = "SwipeAeroSpace";
    swiftbar = "SwiftBar";
  };
  brew = "sudo --user=${user} --set-home /opt/homebrew/bin/brew";
in
lib.mkMerge [
  (lib.mkIf enabled {
    homebrew.taps = [
      "nikitabobko/tap"
      "mediosz/tap"
    ];
    homebrew.casks = [
      "nikitabobko/tap/aerospace"
      "mediosz/tap/swipeaerospace" # 3-finger swipe -> workspaces (config/swipeaerospace)
      "swiftbar" # menu-bar workspace indicator (config/swiftbar)
    ];

    # Hyprland-style border around the focused window (Tokyo Night colours).
    services.jankyborders = {
      enable = true;
      width = 5.0;
      hidpi = true;
      style = "round";
      active_color = "0xff82aaff"; # blue
      inactive_color = "0xff444a73"; # dim
    };

    system.defaults = {
      # AeroSpace recommendations: Spaces in a fixed order, one set per display, and
      # Mission Control grouping that works with AeroSpace's hidden windows.
      dock.mru-spaces = false;
      dock.expose-group-apps = true;
      spaces.spans-displays = false;

      # 3-finger swipes belong to SwipeAeroSpace (left/right: workspaces, up: overview).
      # 4-finger swipes keep the macOS defaults (Spaces / Mission Control).
      trackpad.TrackpadThreeFingerHorizSwipeGesture = 0;
      trackpad.TrackpadThreeFingerVertSwipeGesture = 0;

      # SwiftBar: load plugins (workspace indicator) straight from the repo.
      # Undocumented key; if SwiftBar still asks for a folder, pick config/swiftbar.
      CustomUserPreferences."com.ameba.SwiftBar".PluginDirectory = "${dotfilesDir}/config/swiftbar";
    };
  })

  (lib.mkIf (!enabled) {
    system.activationScripts.postActivation.text = ''
      # windowManager != "aerospace": remove AeroSpace and its helper apps if present.
      ${lib.concatStrings (
        lib.mapAttrsToList (cask: process: ''
          if ${brew} list --cask ${cask} >/dev/null 2>&1; then
            echo "removing ${cask} (windowManager = \"${windowManager}\")" >&2
            pkill -x ${process} || true
            ${brew} uninstall --cask ${cask} || true
          fi
        '') apps
      )}
    '';
  })
]
