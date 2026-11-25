# Window manager, chosen per host with `windowManager = "…"` in flake.nix, then `drs`.
#
# Each window manager is one module here (aerospace.nix, …) that owns everything that
# only exists because of it: apps, helper apps, services, macOS settings, and its own
# cleanup when another one is selected. The rest of the setup (launcher, Karabiner
# launchers, terminal, …) doesn't depend on which one – or none – is active.
#
# Adding one later (e.g. yabai, HyprMac): create wm/<name>.nix following aerospace.nix,
# import it below, add the name to `supported`, and – if it needs keys remapped – add
# its rules in scripts/gen-karabiner.py and its config links in modules/home/dotfiles.nix.
{ lib, windowManager, ... }:
let
  supported = [
    "aerospace"
    "none" # plain macOS windows and Spaces
  ];
in
{
  imports = [ ./aerospace.nix ];

  assertions = [
    {
      assertion = lib.elem windowManager supported;
      message = "windowManager must be one of: ${lib.concatStringsSep ", " supported} (got \"${windowManager}\")";
    }
  ];

  # macOS's own 3-finger gestures (Spaces swipe, Mission Control) unless a window
  # manager module takes them over.
  system.defaults.trackpad = {
    TrackpadThreeFingerHorizSwipeGesture = lib.mkDefault 2;
    TrackpadThreeFingerVertSwipeGesture = lib.mkDefault 2;
  };
}
