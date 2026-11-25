# zsh

Powerful but tastefully minimal zsh configuration.

## Dependencies

### Arch

```sh
paru -S zsh neovim eza bat fd fzf zoxide starship ripgrep
```

### Ubuntu

```sh
sudo apt install zsh neovim eza bat fd-find fzf ripgrep
# install zoxide and starship separately
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl -sS https://starship.rs/install.sh | sh
# Ubuntu installs bat and fd under different names — symlink them so everything works
ln -s $(which batcat) ~/.local/bin/bat
ln -s $(which fdfind) ~/.local/bin/fd
```

### macOS

```sh
brew install zsh neovim eza bat fd fzf zoxide starship ripgrep
```

## Setup

**1. Clone the repo**

```sh
git clone https://github.com/radleylewis/zsh ~/.config/zsh
```

**2. Point zsh at the config directory**

Add the following to `/etc/zsh/zshenv`:

```sh
if [[ -z "$XDG_CONFIG_HOME" ]]
then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

**3. Set zsh as your default shell**

```sh
chsh -s $(which zsh)
```

**4. Create required directories**

```sh
mkdir -p ~/.local/state/zsh   # history
mkdir -p ~/.cache/zsh         # completion cache
```

**5. Start a new shell**

Plugins are installed automatically on first launch via the built-in plugin manager.

## Plugins

Managed without a third-party plugin manager. Plugins are cloned into `$ZDOTDIR/plugins/` on first launch.

| Plugin | Purpose |
|--------|---------|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style inline suggestions |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | Up/down arrow history filtering |
| [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode) | Vi keybindings |

To update all plugins:

```sh
zplugin-update
```

## Keybindings

### Search & navigation (fzf)

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy history search (insert and normal mode) |
| `Ctrl+T` | Fuzzy file search including hidden files, inserts path (fzf + fd) |
| `Ctrl+F` | Fuzzy file search excluding hidden files, inserts path (fzf + fd) |
| `Alt+C` | Fuzzy-find a directory and `cd` into it |
| `**` + `Tab` | fzf completion for paths/args, e.g. `nvim **<Tab>`, `kill **<Tab>` |
| `↑` / `↓` | History search matching what you've typed so far (anywhere in the command) |

### Line editing (insert mode)

These work while typing, without leaving insert mode.

| Key | Action |
|-----|--------|
| `Ctrl+A` / `Ctrl+E` | Jump to start / end of line |
| `Ctrl+→` / `Ctrl+←` | Move forward / backward one word |
| `Ctrl+W` | Delete the word before the cursor |
| `Ctrl+K` | Delete from cursor to end of line |
| `Ctrl+Y` | Paste the last thing deleted with `Ctrl+W` / `Ctrl+K` |
| `Ctrl+U` | **Undo** (zsh-vi-mode remaps this; it is *not* "delete line" like in bash) |
| `Ctrl+_` | Undo |
| `Ctrl+P` / `Ctrl+N` | Previous / next history entry |
| `Ctrl+L` | Clear the screen |
| `Ctrl+D` | List completions (on an empty line: exit the shell) |
| `Ctrl+V` | Insert the next key literally (e.g. a real Tab) |
| `Ctrl+X` `a` | Expand the alias under the cursor (e.g. `ll` → `eza -lh --icons --git`) |
| `Ctrl+X` `m` | Insert the most recently modified file in the current directory |
| `Alt+/` / `Alt+,` | Complete the current word from history (older / newer) |

### Autosuggestions

| Key | Action |
|-----|--------|
| `→` or `Ctrl+E` | Accept the full suggestion |
| `Ctrl+→` | Accept just the next word of the suggestion |
| `Ctrl+\` | Toggle autosuggestions on/off (handy for screen recordings) |

### Vi mode ([zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode))

The shell starts in insert mode. The cursor is a beam in insert mode and a block in normal/visual mode.

| Key | Mode | Action |
|-----|------|--------|
| `Esc` | insert | Switch to normal mode |
| `i` `a` `I` `A` `o` `O` | normal | Enter insert mode (standard vim semantics) |
| `v` / `V` | normal | Visual / visual-line mode |
| `vv` | normal | Edit the current command in `$EDITOR` (nvim) |
| `k` / `j` | normal | Previous / next history entry |
| `/` | normal | Search history backwards |
| `p` / `P` | normal | Paste after / before cursor |
| `gp` / `gP` | normal | Paste from system clipboard after / before cursor |
| `Ctrl+A` / `Ctrl+X` | normal | Increment / decrement number (or toggle `true`/`false`) under cursor |
| `gx` | normal | Open URL / file under cursor |
| `.` | normal | Repeat last change |
| `y` `d` `c` | visual | Yank / delete / change selection |
| `U` / `u` / `~` | visual | Upper / lower / swap case |

All other standard vim motions and operators (`w`, `b`, `e`, `0`, `$`, `f`, `t`, `dw`, `ciw`, `dd`, `u`, …) work as expected.

## Aliases

| Alias | Expands to |
|-------|------------|
| `ls` | `eza --icons auto` |
| `ll` | `eza -lh --icons --git` (long listing with git status) |
| `la` | `eza -lah --icons auto --git` (long listing incl. hidden) |
| `tree` | `eza --tree --icons auto` |
| `cat` | `bat` |
| `grep` | `grep --color=auto` |
| `diff` | `diff --color=auto` |
| `df` | `df -h` |
| `vim` | `nvim` |
| `-` | `cd -` (jump to previous directory) |
| `lf` | `lf` file manager — the shell follows you to the last directory on quit |
| `glog` | `git log` (no pager if it fits on one screen) |
| `gadog` | `git log --all --decorate --oneline --graph` |
| `dotfiles` | `git` for a bare dotfiles repo at `~/.dotfiles` |
| `night` / `day` | Start / stop `gammastep` night light |
| `stream` | Show the `/dev/video4` capture device fullscreen in mpv |

Typing a directory path on its own `cd`s into it (`AUTOCD`), e.g. `..` or `~/Projects`.

## Jumping around with `z` (zoxide)

[zoxide](https://github.com/ajeetdsouza/zoxide) remembers every directory you `cd` into and ranks them by how often and how recently you use them. `z` then jumps to the best match from a few letters of the name, from anywhere.

| Command | Action |
|---------|--------|
| `z proj` | Jump to the highest-ranked directory matching `proj` (e.g. `~/Projects`) |
| `z con qt` | Multiple keywords, matched in order: e.g. `~/.config/qtile` |
| `z ..` / `z ~/path` | Plain paths work too; it acts like `cd` |
| `z -` | Back to the previous directory |
| `z` | Go home |
| `zi` / `zi proj` | Pick from all (or matching) directories interactively with fzf |
| `z proj<Space><Tab>` | Open the fzf picker for matches of `proj` while typing |
| `z <Tab>` | Normal tab completion of directories in the current folder |

Useful extras:

```sh
zoxide query -ls proj   # list matches with their scores
zoxide remove ~/old/dir # forget a directory
zoxide edit             # interactively adjust/remove entries
```

`z` only knows directories you've visited since installing zoxide, so it gets better the more you use it. The last keyword has to match the *final* part of the path: `z qt` finds `~/.config/qtile`, but `z config` won't jump to `~/.config/qtile`.

## Starship Config

Included in the repo at [`starship.toml`](./starship.toml) and loaded automatically via `STARSHIP_CONFIG` in `.zshenv`. Requires a [Nerd Font](https://www.nerdfonts.com) in your terminal.
