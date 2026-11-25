# macOS preferences (the `defaults write` stuff), applied on every rebuild.
# Some settings only take effect after logging out and back in.
{ user, dotfilesDir, ... }:
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
      # Allow ⌘Q on Finder, so it doesn't sit in the Dock as "running" forever.
      # While quit, desktop icons are hidden; clicking Finder in the Dock relaunches it.
      QuitMenuItem = true;
    };

    trackpad = {
      Clicking = false; # tap to click
      TrackpadThreeFingerDrag = false;
      # 3-finger swipes belong to SwipeAeroSpace (left/right: workspaces, up: overview).
      # 4-finger swipes keep the macOS defaults (Spaces / Mission Control).
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 0;
    };

    screencapture = {
      location = "/Users/${user}/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
    };

    loginwindow.GuestEnabled = false;

    # SwiftBar: load plugins (workspace indicator) straight from the repo.
    # Undocumented key; if SwiftBar still asks for a folder, pick config/swiftbar.
    CustomUserPreferences."com.ameba.SwiftBar".PluginDirectory = "${dotfilesDir}/config/swiftbar";
  };

  system.activationScripts.postActivation.text = ''
    # screencapture.location must exist.
    sudo -u ${user} mkdir -p /Users/${user}/Pictures/Screenshots

    # Free ⌘Space for Raycast: disable Spotlight's "Show Spotlight search" shortcut (id 64).
    # `-dict-add` merges this one entry, so other shortcuts changed in System Settings stay.
    sudo -u ${user} defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
      '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'
    sudo -u ${user} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
