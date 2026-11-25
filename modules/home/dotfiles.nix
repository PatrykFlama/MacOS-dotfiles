# App configs stay as plain files in config/ and are symlinked into ~/.config.
# The links point at this repo (not the nix store), so editing a file takes
# effect immediately, with no rebuild. A rebuild is only needed to add a new entry.
{
  config,
  lib,
  dotfilesDir,
  windowManager,
  ...
}:
let
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${path}";
in
{
  xdg.configFile = {
    "ghostty".source = link "ghostty";
    "nvim".source = link "nvim";
    "tmux".source = link "tmux";
    # Karabiner: generated, not linked – see karabiner.nix.
  }
  // lib.optionalAttrs (windowManager == "aerospace") {
    "aerospace".source = link "aerospace";
    # SwipeAeroSpace reads ~/.config/swipeareospace (sic).
    "swipeareospace".source = link "swipeaerospace";
  };
}
