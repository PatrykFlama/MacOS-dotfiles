{ user, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./dotfiles.nix
    ./scripts.nix
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";

  xdg.enable = true;

  # Read the home-manager changelog before bumping this.
  home.stateVersion = "25.11";
}
