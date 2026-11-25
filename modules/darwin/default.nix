{
  pkgs,
  hostname,
  user,
  ...
}:
{
  imports = [
    ./defaults.nix
    ./homebrew.nix
    ./launcher.nix
    ./keymap.nix
    ./wm
  ];

  # Nix itself is managed by the Determinate installer, not by nix-darwin.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;
  networking.localHostName = hostname;
  networking.computerName = hostname;

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  # Make zsh aware of nix paths (it is the macOS default shell anyway).
  programs.zsh.enable = true;

  # sudo with Touch ID (also works inside tmux thanks to pam-reattach).
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  time.timeZone = "Europe/Warsaw";

  # Read the nix-darwin changelog before bumping this.
  system.stateVersion = 6;
}
