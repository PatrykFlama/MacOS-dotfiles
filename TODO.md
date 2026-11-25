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

## Later / maybe

- [ ] Check Raycast's `⌃↵` (New Application Window) with AeroSpace: does the new window
      land on the current workspace, or does AeroSpace first jump to the app's existing
      workspace? If it jumps, add an AeroSpace rule/script to pull the new window back.
- [ ] Raycast `↵` on a running app only focuses it ("Open" is the fixed primary action;
      "New Application Window" is `⌃↵`, not remappable). Possible AeroSpace-side idea
      later; a Karabiner ↵/⌃↵ swap inside Raycast was rejected (breaks all other items).
- [ ] SketchyBar, if the native menu bar isn't enough.
- [ ] Try **HyprMac** (github.com/zacharytgray/HyprMac, `brew install --cask hyprmac`) if
      AeroSpace's manual i3-style tree gets annoying. Pros: Hyprland-like automatic dwindle
      tiling, built-in Hypr key (Caps Lock / F13–F20, so no Karabiner), signed, overview,
      dims inactive windows. Cons: no real animations either (same approach as AeroSpace),
      no gestures without BetterTouchTool, config via GUI (JSON in Application Support),
      very young (v0.29, ~daily releases), macOS 27 support unconfirmed.
- [ ] Workspace-switch animations: AeroSpace has none by design. Only option is yabai
      (native Spaces, macOS slide animation) - needs partial SIP disable for full features.
