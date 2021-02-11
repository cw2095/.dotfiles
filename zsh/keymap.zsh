function zle_eval {
    echo -en "\e[2K\r"
    eval "$@"
    zle redisplay
}

function openlazygit {
    zle_eval lazygit
}

zle -N openlazygit; bindkey "^G" openlazygit

bindkey -r '^P'
bindkey -r '^O'
bindkey '^n' zfm-cd-to-bookmark
bindkey '^b' zfm-insert-bookmark
