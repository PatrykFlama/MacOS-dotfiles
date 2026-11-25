# TODO

Open ideas and follow-ups for this setup. Maintained together with Claude.

## Keyboard

- [ ] **Free up `⌃←` / `⌃→` / `⌃↑` / `⌃↓`.** macOS uses them to switch Spaces and for
      Mission Control/app windows, which steals word-jump in terminals (and AeroSpace
      replaces Spaces anyway). Disable like the Spotlight shortcut in
      `modules/darwin/defaults.nix` (`defaults write com.apple.symbolichotkeys
      AppleSymbolicHotKeys -dict-add <id> …` in postActivation, which merges single entries).
      IDs: 79/80/81/82 (Spaces left/right), 32/34 (Mission Control), 33/35 (app windows).
- [ ] **Make `Home` / `End` work per line** (macOS default: start/end of document) via
      `~/Library/KeyBindings/DefaultKeyBinding.dict`, managed by home-manager.
      Only affects native Cocoa apps; browsers/Electron handle these keys themselves.
- [ ] Update `docs/keybindings.md` once the two items above are done.

## Homebrew

- [ ] Once the cask list in `modules/darwin/homebrew.nix` feels final, switch
      `onActivation.cleanup` from `"none"` to `"zap"` so Homebrew mirrors the config
      (removes leftovers like the old `vim` formula).

## AeroSpace

- [ ] Migrate `config/aerospace/aerospace.toml` to `config-version = 2` (AeroSpace warns
      on reload that version 1 is outdated; see the guide's "config-version" section).

- [ ] Hyprland-style "swipe past last workspace = new empty workspace". SwipeAeroSpace
      stops at the last occupied workspace (`skipEmptyTarget` returns nil when
      `wrap = false`) and has no custom-command hook. Plan: open a feature request / small
      PR upstream (github.com/MediosZ/SwipeAeroSpace): at the end, focus the first unused
      workspace instead of stopping. Fallbacks: `skip-empty = false` (swipes through all
      10 numbered workspaces) or BetterTouchTool + script (paid).

- [ ] Hyprland-style dwindle (each new window splits the focused one). AeroSpace has no
      such layout (only tiles/accordion); watch upstream issue #260
      (github.com/nikitabobko/AeroSpace/issues/260, "more sophisticated normalizations",
      mentions bsp). Interim options: a script on new windows that runs `join-with`
      (imitation; may flicker / guess direction wrong), or bind `join-with` to keys and
      split manually. Real dwindle elsewhere = yabai bsp (we decided against yabai).

- [ ] Closing the last window on a workspace jumps to another workspace (AeroSpace bug
      #1097, open: macOS focuses another app's window and AeroSpace follows). Tried: ⌥Q
      remembers the workspace, closes, sleeps 0.2 s, switches back – worked badly, reverted.
      Wait for an upstream fix (watch #1097).

## Later / maybe

- [ ] "New window here" for already-running apps (Raycast/Spotlight just focus them, and
      Raycast 2.13 has no "New Application Window" action despite the manual). Plan: a
      `new-window <app>` script – Chrome-family `open -na … --args --new-window`,
      LibreWolf/Firefox equivalent (test), Ghostty `ghostty-window`, VS Code `code -n`,
      Finder AppleScript, fallback: focus app + ⌘N, then move the new window back to the
      original workspace (needs Accessibility). Expose as Raycast script commands
      ("New Chrome Window"…) and/or a key like ⌥N for the focused app.
- [ ] SketchyBar, if the native menu bar isn't enough.
- [ ] Try **HyprMac** (github.com/zacharytgray/HyprMac, `brew install --cask hyprmac`) if
      AeroSpace's manual i3-style tree gets annoying. Pros: Hyprland-like automatic dwindle
      tiling, built-in Hypr key (Caps Lock / F13–F20, so no Karabiner), signed, overview,
      dims inactive windows. Cons: no real animations either (same approach as AeroSpace),
      no gestures without BetterTouchTool, config via GUI (JSON in Application Support),
      very young (v0.29, ~daily releases), macOS 27 support unconfirmed.
      To try it: add `modules/darwin/wm/hyprmac.nix` (pattern: `wm/aerospace.nix`) and set
      `windowManager = "hyprmac"` in flake.nix.
- [ ] Workspace-switch animations: AeroSpace has none by design. Only option is yabai
      (native Spaces, macOS slide animation) - needs partial SIP disable for full features.
