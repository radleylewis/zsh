# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# Suggest from history first, then fall back to tab completion (e.g. folders you've
# never cd'd into). Must be set before the plugin loads.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load jeffreytse zsh-vi-mode
_zplugin_load zdharma-continuum fast-syntax-highlighting
# must load after the syntax highlighter (per zsh-history-substring-search docs)
_zplugin_load zsh-users zsh-history-substring-search
