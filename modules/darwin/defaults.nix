# macOS preferences (the `defaults write` stuff), applied on every rebuild.
# Some settings only take effect after logging out and back in.
{ user, ... }:
{
  system.defaults = {
    NSGlobalDomain = {
      # Fast key repeat; disable the accent popup so held keys repeat (vim!).
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;

      AppleShowAllExtensions = true;
      AppleInterfaceStyleSwitchesAutomatically = true;

      # No "smart" text mangling.
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Expanded save/print dialogs by default.
      NSNavPanelExpandedStateForSaveMode = true;
      PMPrintingExpandedStateForPrint = true;

      # Drag windows by holding ctrl+cmd anywhere on them.
      NSWindowShouldDragOnGesture = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      show-recents = false;
      tilesize = 48;
      # Keep Spaces in a fixed order (required for a sane AeroSpace experience).
      mru-spaces = false;
      # AeroSpace recommendation: makes Mission Control usable with its hidden windows.
      expose-group-apps = true;
    };

    # AeroSpace recommendation: one set of Spaces per display.
    spaces.spans-displays = false;

    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      FXDefaultSearchScope = "SCcf"; # search the current folder
      FXEnableExtensionChangeWarning = false;
      _FXSortFoldersFirst = true;
      NewWindowTarget = "Home";
    };

    trackpad = {
      Clicking = true; # tap to click
      TrackpadThreeFingerDrag = true;
    };

    screencapture = {
      location = "/Users/${user}/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
    };

    loginwindow.GuestEnabled = false;
  };

  # screencapture.location must exist.
  system.activationScripts.postActivation.text = ''
    sudo -u ${user} mkdir -p /Users/${user}/Pictures/Screenshots
  '';
}
