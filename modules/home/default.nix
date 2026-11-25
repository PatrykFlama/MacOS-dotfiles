{ user, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./dotfiles.nix
    ./karabiner.nix
    ../../scripts
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";

  xdg.enable = true;

  # Read the home-manager changelog before bumping this.
  home.stateVersion = "26.05";
}
