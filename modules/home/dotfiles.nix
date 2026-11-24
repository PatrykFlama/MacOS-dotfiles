# App configs stay as plain files in config/ and are symlinked into ~/.config.
# The links point at this repo (not the nix store), so editing a file takes
# effect immediately, with no rebuild. A rebuild is only needed to add a new entry.
{ config, dotfilesDir, ... }:
let
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${path}";
in
{
  xdg.configFile = {
    "aerospace".source = link "aerospace";
    "ghostty".source = link "ghostty";
    "karabiner".source = link "karabiner";
    "nvim".source = link "nvim";
    "tmux".source = link "tmux";
  };
}
