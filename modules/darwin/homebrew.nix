# GUI apps come from Homebrew casks (signed, auto-updating, actually work on macOS),
# but the list is declared here. CLI tools come from nixpkgs (see modules/home/packages.nix).
{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      # Don't update/upgrade on every rebuild (slow, needs network, and upgrades apps in
      # the middle of unrelated config changes). `dup` does it explicitly.
      autoUpdate = false;
      upgrade = false;
      # "none" leaves anything not listed here alone. Once you're happy with the
      # list, switch to "zap" so Homebrew mirrors this file exactly.
      cleanup = "none";
    };

    # Window-manager apps (AeroSpace & co.) are added by modules/darwin/wm/,
    # the launcher (Raycast) by modules/darwin/launcher.nix.
    taps = [ ];

    brews = [ ];

    casks = [
      # desktop / workflow
      "ghostty" # terminal
      "karabiner-elements" # left-Option launchers/WM keys (scripts/gen-karabiner.py)

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
