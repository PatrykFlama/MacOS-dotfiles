# MacOS-dotfiles

Declarative macOS setup: **nix-darwin** (system + macOS preferences) + **home-manager** (user env)
+ **Homebrew casks declared from Nix** (GUI apps). App configs are plain files in `config/`,
symlinked into `~/.config`, so they can be edited live without rebuilding.

## Layout

```
flake.nix                 inputs + one entry per machine (hostname, user, repo path)
modules/darwin/
  default.nix             nix settings, hostname, Touch ID sudo, fonts, window borders
  defaults.nix            macOS preferences (Dock, Finder, keyboard, trackpad…)
  homebrew.nix            GUI apps (casks)
modules/home/
  packages.nix            CLI tools (nixpkgs) + tools with home-manager modules
  shell.nix               zsh, aliases, prompt
  git.nix                 git + delta
  dotfiles.nix            which config/ dirs get symlinked into ~/.config
config/                   aerospace, ghostty, karabiner, nvim, swiftbar, swipeaerospace, tmux
scripts/                  fsearch, tiling-toggle, gen-karabiner.py + default.nix
docs/keybindings.md       keybindings cheatsheet
```

## First-time setup

1. Xcode command line tools: `xcode-select --install`
2. Install Nix (Determinate installer – survives macOS updates):
   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```
   Open a new terminal afterwards.
3. Clone this repo to `~/<pathto>/MacOS-dotfiles` (or change `dotfilesDir` in `flake.nix`).
4. First build (installs `darwin-rebuild`):
   ```sh
   sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/<pathto>/MacOS-dotfiles
   ```
5. Log out and back in (some macOS defaults need it), then:
   - open **AeroSpace** once and grant Accessibility permission,
   - open **Karabiner-Elements** once and approve what it asks for (driver/system extension,
     Input Monitoring). It provides the left-Option window-manager key.
   - open **SwipeAeroSpace** once and grant Accessibility permission (trackpad gestures).
   - open **SwiftBar** once (menu-bar workspace indicator); if it asks for a plugin folder,
     choose `config/swiftbar` in this repo. Optionally hide AeroSpace's own menu-bar icon in
     *System Settings → Menu Bar*.

## Window-manager key

AeroSpace bindings are written as `ctrl-alt-*`; Karabiner maps **left Option** + those keys
to ctrl+option, so in practice you press left ⌥. Right ⌥ keeps typing Polish letters.
App launchers and the tiling toggle (left ⌥⇧T, `scripts/tiling-toggle`) are Karabiner rules
that run commands directly, so they still work while AeroSpace is switched off (native
macOS window behaviour). Both live in `scripts/gen-karabiner.py`.

After adding/removing an AeroSpace binding, regenerate the Karabiner rule:

```sh
python3 scripts/gen-karabiner.py
```
