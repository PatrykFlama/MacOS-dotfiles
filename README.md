# MacOS-dotfiles

Declarative macOS setup: **nix-darwin** (system + macOS preferences) + **home-manager** (user env)
+ **Homebrew casks declared from Nix** (GUI apps). App configs are plain files in `config/`,
symlinked into `~/.config`, so they can be edited live without rebuilding.

## Layout

```
flake.nix                 inputs + one entry per machine (hostname, user, repo path)
modules/darwin/
  default.nix             nix settings, hostname, Touch ID sudo, fonts
  defaults.nix            macOS preferences (Dock, Finder, keyboard, trackpad…)
  homebrew.nix            GUI apps (casks)
modules/home/
  packages.nix            CLI tools (nixpkgs) + tools with home-manager modules
  shell.nix               zsh, aliases, prompt
  git.nix                 git + delta
  dotfiles.nix            which config/ dirs get symlinked into ~/.config
config/                   aerospace, ghostty, nvim, tmux
scripts/                  fsearch + default.nix (installs them as commands)
```

## First-time setup

1. Xcode command line tools: `xcode-select --install`
2. Install Nix (Determinate installer – survives macOS updates):
   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```
   Open a new terminal afterwards.
3. Clone this repo to `~/Documents/MacOS-dotfiles` (or change `dotfilesDir` in `flake.nix`).
4. First build (installs `darwin-rebuild`):
   ```sh
   sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/Documents/MacOS-dotfiles
   ```
5. Log out and back in (some macOS defaults need it), then open **AeroSpace** once and grant Accessibility permission.
