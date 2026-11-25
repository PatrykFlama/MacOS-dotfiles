# Keybindings cheatsheet

Symbols: `⌘` Cmd · `⌥` Option · `⌃` Ctrl · `⇧` Shift · `⌫` Backspace · `↵` Return

> **Polish Pro layout:** `⌥ + letter` types ą ę ś ł ż ź ć ń ó. **Left ⌥** + window-manager keys belongs to AeroSpace;
> **right ⌥** always types Polish letters. In Ghostty, other left-⌥ combos act as Alt.

---

## Window manager – AeroSpace (mod = **left** `⌥`)

Left ⌥ is turned into `⌃⌥` by Karabiner for the keys below (real `⌃⌥` works too).
Left ⌥ + arrows stays word-jump. Type **ł** with right ⌥ (left ⌥ L = focus right).

**Always on** (Karabiner – work in both tiling and native mode):

| Keys | Action |
| --- | --- |
| `⌥⇧ T` | **Toggle tiling** on / off. Off = native windows, no borders, macOS 3-finger gestures (SwipeAeroSpace quits) |
| `⌥ ↵` | New terminal (Ghostty) |
| `⌥ F` | Finder (home folder) |
| `⌥⇧ F` | yazi in a new terminal |
| `⌥⇧ /` (`⌥?`) | This cheatsheet (floating window, `q` to close) |
| `⌥ Space` | Spotlight |

**Tiling** (AeroSpace – off while tiling is toggled off; use `⌘W` to close windows then):

| Keys | Action |
| --- | --- |
| `⌥ Q` | Close window |
| `⌥ V` | Toggle floating / tiling |
| `⌥ M` | Fullscreen |
| `⌥ /` | Tiles layout (toggle horizontal / vertical) |
| `⌥ ,` | Accordion layout (toggle horizontal / vertical) |
| `⌥ H J K L` (or `⌃⌥` + arrows) | Focus left / down / up / right |
| `⌥⇧ H J K L` (or `⌃⌥⇧` + arrows) | Move window |
| `⌥ -` / `⌥ =` | Shrink / grow window |
| `⌥ 1 … 9, 0` | Go to workspace 1 … 10 |
| `⌥⇧ 1 … 9, 0` | Move window to workspace 1 … 10 |
| `⌥ Tab` | Previous workspace |
| `⌥⇧ Tab` | Move workspace to next monitor |
| `⌥ R` | Reload AeroSpace config |
| `⌥⇧ ;` | Enter **service mode** ↓ |

**Service mode** (one key, then back to normal):

| Key | Action |
| --- | --- |
| `R` | Reset layout (flatten workspace tree) |
| `F` | Toggle floating / tiling |
| `⌫` | Close all windows except current |
| `Esc` | Reload config & exit |

Mouse: hold `⌃⌘` and drag anywhere on a window to move it.

**Trackpad** (SwipeAeroSpace):

| Gesture | Action |
| --- | --- |
| 3 fingers ← / → | Previous / next workspace (skips empty ones) |
| 3 fingers ↑ | Workspace overview |
| 4 fingers ← / → / ↑ | macOS Spaces / Mission Control (rarely useful with AeroSpace) |

---

## macOS – system

| Keys | Action |
| --- | --- |
| `⌘ Space` or left `⌥ Space` | Spotlight (launch apps, calculator, search) |
| `⌘ Tab` / `⌘ ⇧ Tab` | Switch **apps** |
| `` ⌘ ` `` | Cycle windows of the current app |
| `⌘ W` | Close window / tab |
| `⌘ Q` | Quit app (closing the last window does *not* quit) |
| `⌘ H` / `⌘ ⌥ H` | Hide app / hide all others |
| `⌘ M` | Minimise |
| `⌘ ,` | App settings |
| `⌘ ⌥ Esc` | Force quit dialog |
| `⌃ ⌘ Q` | Lock screen |
| `⌃ ⌘ Space` | Emoji & symbols picker |
| `⌃ Space` | Switch keyboard input source |
| `⌃ ↑` / `⌃ ↓` | Mission Control / app windows (macOS default) |
| `⌃ ←` / `⌃ →` | Switch Spaces (macOS default – overrides word-jump in terminals) |

### Screenshots

| Keys | Action |
| --- | --- |
| `⌘ ⇧ 3` | Whole screen → file |
| `⌘ ⇧ 4` | Select area → file |
| `⌘ ⇧ 4`, then `Space` | Pick a window → file |
| `⌘ ⇧ 5` | Screenshot / screen recording toolbar |
| add `⌃` to any of the above | → clipboard instead of file |

Files go to `~/Pictures/Screenshots`.

---

## Text editing (works in every native text field)

| Keys | Action |
| --- | --- |
| `⌥ ←` / `⌥ →` | Previous / next word |
| `⌘ ←` / `⌘ →` | Start / end of line |
| `⌘ ↑` / `⌘ ↓` | Start / end of document |
| `Home` / `End` | Start / end of **document** (not line!) |
| `⌥ ⌫` | Delete word left |
| `⌘ ⌫` | Delete to start of line |
| `Fn ⌫` | Forward delete |
| add `⇧` to any movement | Select |
| `⌃ A` / `⌃ E` | Start / end of line (emacs-style) |
| `⌃ K` | Delete to end of line |
| `⌘ Z` / `⌘ ⇧ Z` | Undo / redo |

---

## Finder

| Keys | Action |
| --- | --- |
| `↵` | **Rename** (not open!) |
| `⌘ O` or `⌘ ↓` | Open |
| `⌘ ↑` | Parent folder |
| `Space` | Quick Look preview |
| `⌘ ⌫` | Move to Bin |
| `⌘ C`, then `⌘ ⌥ V` | **Move** file (there is no cut) |
| `⌘ ⇧ G` | Go to path |
| `⌘ ⇧ .` | Toggle hidden files |
| `⌘ ⇧ N` | New folder |
| `⌘ ⌥ C` | Copy path of selected file |
| `⌘ 1 / 2 / 3 / 4` | Icon / list / column / gallery view |

---

## Ghostty (terminal)

| Keys | Action |
| --- | --- |
| `⌘ T` / `⌘ W` | New tab / close |
| `⌘ 1 … 9` | Go to tab |
| `⌘ D` / `⌘ ⇧ D` | Split right / down |
| `⌘ [` / `⌘ ]` | Previous / next split |
| `⌘ +` / `⌘ -` / `⌘ 0` | Font bigger / smaller / reset |
| `⌘ K` | Clear screen |
| `⌘ ⇧ ,` | Reload config |
| select text | Copied to clipboard automatically |

---

## zsh

| Keys / command | Action |
| --- | --- |
| `⌃ R` | Fuzzy search history (fzf) |
| `⌃ T` | Fuzzy pick a file, insert its path |
| `Alt C` (left ⌥) | Fuzzy cd into a subdirectory |
| `→` (or `⌃ E`) | Accept autosuggestion |
| `⌃ A` / `⌃ E` | Start / end of line |
| `⌃ W` / `⌃ U` | Delete word / whole line |
| `z <name>` | Jump to a frequently used dir (zoxide) |
| `y` | yazi file manager (cd to its dir on quit) |
| `fsearch [depth]` | Fuzzy search file contents |
| `ff` | Fuzzy pick a file with preview |
| ` command` (leading space) | Not saved to history |
| `drs` / `dup` | Apply config / update inputs + apply |

---

## tmux (prefix = `⌃A`)

| Keys | Action |
| --- | --- |
| `⌃A` `\|` / `⌃A` `-` | Split side by side / top & bottom |
| `⌃A` `c` | New window |
| `⌃A` `h j k l` | Focus pane |
| `⌃A` `H J K L` | Resize pane (repeatable) |
| `⌃A` `r` | Reload config |
| `⌃A` `d` | Detach |
| `⌃A` `[` | Copy mode (`v` select, `⌃V` block, `y` yank to clipboard) |
| `⌃A` `⌃A` | Send a literal `⌃A` |
| `⇧ ←` / `⇧ →` | Previous / next window |

Mouse works (click panes, drag borders, scroll).

---

## Neovim (leader = `Space`)

| Keys | Action |
| --- | --- |
| `Space w` | Save |
| `Space q` | Quit |
| `Esc` | Clear search highlight |
| `⌃ H J K L` | Move between splits |
