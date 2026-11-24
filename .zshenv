# ~/.config/zsh/.zshenv

# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Editor ----------
# Default editor used by git, crontab, etc.
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- Pager ----------
# col -bx strips man's backspace formatting; MANROFFOPT=-c avoids ANSI escapes bat can't parse
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  export MANROFFOPT="-c"
fi

# ---------- Starship ----------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# ---------- PATH ----------
# Keep PATH entries unique (nested shells would otherwise prepend duplicates)
typeset -U path PATH

# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"
