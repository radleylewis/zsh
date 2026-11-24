# Powerful but minimal zsh configuration
# Author: Radley E. Sidwell-Lewis
# GitHub: https://www.github.com/radleylewis/zsh
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY  # implies appending, so APPEND_HISTORY isn't needed
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY         # show !!/!$ expansions for review instead of running them immediately
setopt HIST_REDUCE_BLANKS  # strip superfluous whitespace before saving
setopt EXTENDED_HISTORY    # record timestamp + duration (see: history -i)

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# GPG pinentry needs the current tty (interactive shells only, so it lives here not .zshenv)
export GPG_TTY=$TTY

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
# (dir must exist, otherwise the dump is never written and compinit rescans every startup)
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Include dotfiles in completion without having to type the leading "."
_comp_options+=(globdots)

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# Colour completion lists like ls (falls back to zsh's default colours when LS_COLORS is unset)
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# =========================================================
# Smart directory navigation
# =========================================================

# (lf reads ~/.config/lf/icons itself, so no LF_ICONS export is needed)

# Initialize zoxide (must come after compinit so its `z` completions get registered)
eval "$(zoxide init zsh)"

# =========================================================
# Fuzzy finder
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Local Git-cloned fzf
if [[ -f "$HOME/.fzf/shell/key-bindings.zsh" ]]; then
  source "$HOME/.fzf/shell/key-bindings.zsh"
  source "$HOME/.fzf/shell/completion.zsh"
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"


# =========================================================
# User Custom Configurations
# =========================================================

if [[ -f "$ZDOTDIR/local.zsh" ]]; then
  source "$ZDOTDIR/local.zsh"
fi
