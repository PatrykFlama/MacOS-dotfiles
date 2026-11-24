# TODO

Open ideas and follow-ups for this setup. Maintained together with Claude.

## Keyboard

- [ ] **Free up `⌃←` / `⌃→` / `⌃↑` / `⌃↓`.** macOS uses them to switch Spaces and for
      Mission Control/app windows, which steals word-jump in terminals (and AeroSpace
      replaces Spaces anyway). Disable via
      `system.defaults.CustomUserPreferences."com.apple.symbolichotkeys"` in
      `modules/darwin/defaults.nix`.
      Caveat: this rewrites the whole shortcuts dict, so later manual changes in
      *System Settings → Keyboard Shortcuts* get reset on rebuild unless added to the config.
- [ ] **Make `Home` / `End` work per line** (macOS default: start/end of document) via
      `~/Library/KeyBindings/DefaultKeyBinding.dict`, managed by home-manager.
      Only affects native Cocoa apps; browsers/Electron handle these keys themselves.
- [ ] Update `docs/keybindings.md` once the two items above are done.

## Homebrew

- [ ] Once the cask list in `modules/darwin/homebrew.nix` feels final, switch
      `onActivation.cleanup` from `"none"` to `"zap"` so Homebrew mirrors the config
      (removes leftovers like the old `vim` formula).

## Later / maybe

- [ ] Revisit launcher after a Spotlight trial (Raycast was dropped for now).
- [ ] Karabiner-Elements: Caps Lock → `⌃⌥` / Hyper, so AeroSpace bindings are one key.
- [ ] SketchyBar, if the native menu bar isn't enough.
