if [[ -n "$ZSH_VERSION" ]]; then

bindkey "^G" openlazygit
bindkey -r '^P'
bindkey -r '^O'
bindkey '^n' zfm-cd-to-bookmark
bindkey '^b' zfm-insert-bookmark

bindkey '^v' edit-command-line

# Bind C+Space to accept the current suggestion
bindkey '^ ' autosuggest-accept

# bindkey '^P' history-substring-search-up
# bindkey '^N' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
bindkey ${terminfo[kcuu1]} history-substring-search-up
bindkey ${terminfo[kcud1]} history-substring-search-down
fi

# fzf
bindkey '^f' fzf-find-widget
bindkey '^s' find-in-file
bindkey '^h' fzf-history-widget
bindkey '^t' fzf-cd-widget

bindkey -s '\e;' 'll\n'
bindkey -s '\eu' 'ranger_cd\n'
bindkey -s '\eg'  'lazygit\n'

fi

# ''\e' = <esc>
# default bash key binding
if [[ -n "$BASH_VERSION" ]]; then
    bind '"\eh":"\C-b"'
    bind '"\el":"\C-f"'
    bind '"\ej":"\C-n"'
    bind '"\ek":"\C-p"'
    bind '"\eH":"\eb"'
    bind '"\eL":"\ef"'
    bind '"\eJ":"\C-a"'
    bind '"\eK":"\C-e"'
    bind '"\e;":"ll\n"'
fi

