# GUI apps come from Homebrew casks (signed, auto-updating, actually work on macOS),
# but the list is declared here. CLI tools come from nixpkgs (see modules/home/packages.nix).
{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none" leaves anything not listed here alone. Once you're happy with the
      # list, switch to "zap" so Homebrew mirrors this file exactly.
      cleanup = "none";
    };

    taps = [ "nikitabobko/tap" ];

    brews = [ ];

    casks = [
      # desktop / workflow
      "nikitabobko/tap/aerospace" # tiling window manager (Hyprland replacement)
      "ghostty" # terminal
      "karabiner-elements" # left Option -> AeroSpace modifier (see config/karabiner)

      # browsers
      "google-chrome"
      "librewolf"
      # "firefox"

      # dev
      "visual-studio-code"
      "claude-code"

      # everyday
      "spotify"
      "discord"
      #"vlc"
      #"thunderbird"
      #"libreoffice"

      # "sublime-text"
      # "krita"
      # "audacity"
      # "kdenlive"
      # "freecad"
      # "ultimaker-cura"
      # "arduino-ide"
      # "raspberry-pi-imager"
      # "anydesk"
      # "ollama-app"
      # "steam"
    ];

    # Mac App Store apps: requires being signed in to the App Store.
    # masApps = { "Xcode" = 497799835; };
  };
}
