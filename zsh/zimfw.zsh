[[ -z "$ZSH_VERSION" ]] && return

# zim framework
ZDOTDIR="$HOME/.local/zsh"
ZIMDIR="$ZDOTDIR/.zim"

if [ ! -d "$ZIMDIR" ]; then
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [ ! -d "$HOME/.local/zsh" ] && mkdir -p "$HOME/.local/zsh" 2> /dev/null
    git clone --recursive https://github.com/zimfw/zimfw.git "$ZIMDIR"

    setopt EXTENDED_GLOB
    for template_file ( ${ZDOTDIR:-${HOME}}/.zim/templates/* ); do
        user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
        touch ${user_file}
        ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
    done
fi
