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
5. Log out and back in (some macOS defaults need it), then:
   - open **AeroSpace** once and grant Accessibility permission,
   - open **Raycast**, set its hotkey to `cmd+space` (disable Spotlight's shortcut in
     System Settings → Keyboard → Keyboard Shortcuts → Spotlight).

New machine? Add another `mkHost { … }` entry in `flake.nix` named after
`scutil --get LocalHostName`.

## Daily use

| Command | What it does |
| --- | --- |
| `drs` (or `nrs`) | apply config (`darwin-rebuild switch`) |
| `dup` | update flake inputs, then apply |
| `nix flake update` + commit `flake.lock` | pin newer package versions |
| `fsearch [depth]` | fuzzy-search file contents |
| `y` | yazi, cd's to the last dir on quit |
| `z <dir>` | jump to a frequently-used dir |

Rollback: `sudo darwin-rebuild --rollback`.

## Keybindings (AeroSpace)

Modifier is **ctrl+option** – plain option types Polish characters on the Polish Pro layout.

| Keys | Action |
| --- | --- |
| `ctrl+opt+enter` | terminal (Ghostty) |
| `ctrl+opt+f` / `+shift` | Finder / yazi |
| `ctrl+opt+q` | close window |
| `ctrl+opt+v` | toggle floating |
| `ctrl+opt+m` | fullscreen |
| `ctrl+opt+h/j/k/l` (or arrows) | focus; add `shift` to move |
| `ctrl+opt+1..0` | workspace; add `shift` to move window there |
| `ctrl+opt+/` / `,` | tiles / accordion layout |
| `ctrl+opt+-` / `=` | resize |
| `ctrl+opt+tab` | previous workspace |
| `ctrl+opt+r` | reload AeroSpace config |
| `ctrl+opt+shift+;` | service mode (`r` reset layout, `esc` exit) |

macOS-native: `cmd+space` launcher (Raycast), `cmd+shift+4/5` screenshots,
`ctrl+cmd+q` lock screen.

In Ghostty, **left** option acts as Alt (tmux `alt+hjkl`, `alt+1..9`);
**right** option types ą ę ś ł ż ź ć ń ó.
