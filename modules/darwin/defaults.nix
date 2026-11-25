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
    };

    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      FXDefaultSearchScope = "SCcf"; # search the current folder
      FXEnableExtensionChangeWarning = false;
      _FXSortFoldersFirst = true;
      NewWindowTarget = "Home";
      # Allow ⌘Q on Finder, so it doesn't sit in the Dock as "running" forever.
      # While quit, desktop icons are hidden; clicking Finder in the Dock relaunches it.
      QuitMenuItem = true;
    };

    trackpad = {
      Clicking = false; # tap to click
      TrackpadThreeFingerDrag = false;
      # 3-finger swipe gestures: set by the window-manager module (modules/darwin/wm/).
    };

    screencapture = {
      location = "/Users/${user}/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
      # Floating thumbnail after a screenshot: click it to edit (left ⌥⇧S relies on it).
      show-thumbnail = true;
    };

    loginwindow.GuestEnabled = false;
  };

  system.activationScripts.postActivation.text = ''
    # screencapture.location must exist.
    sudo -u ${user} mkdir -p /Users/${user}/Pictures/Screenshots
  '';
}
