export FZF_DEFAULT_COMMAND='fd --hidden --follow -E ".git" -E "node_modules" . /etc /home'
export fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'
# export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --bind=alt-j:down,alt-k:up,alt-i:toggle+down --border --preview "echo {} | ~/.dotfiles/bin/fzf_preview.py" --preview-window=down'
export FZF_DEFAULT_OPTS='--bind=alt-j:down,alt-k:up,alt-i:toggle+down --preview "echo {} | ~/.dotfiles/bin/preview.sh" '
export FZF_COMPLETION_TRIGGER='\'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow -E ".git" -E "node_modules" . "$1" /etc /home
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow -E ".git" -E "node_modules" . "$1" /etc /home
}

_fzf_fpath=${0:h}/fzf
fpath+=$_fzf_fpath
autoload -U $_fzf_fpath/*(.:t)
unset _fzf_fpath

fzf-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
        $precmd
    done
    zle reset-prompt
}
zle -N fzf-redraw-prompt

zle -N fzf-find-widget
bindkey '^p' fzf-find-widget

fzf-cd-widget() {
    local tokens=(${(z)LBUFFER})
    if (( $#tokens <= 1 )); then
        zle fzf-find-widget 'only_dir'
        if [[ -d $LBUFFER ]]; then
            cd $LBUFFER
            local ret=$?
            LBUFFER=
            zle fzf-redraw-prompt
            return $ret
        fi
    fi
}
zle -N fzf-cd-widget
bindkey '^t' fzf-cd-widget

fzf-history-widget() {
    local num=$(fhistory $LBUFFER)
    local ret=$?
    if [[ -n $num ]]; then
        zle vi-fetch-history -n $num
    fi
    zle reset-prompt
    return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

find-in-file() {
    grep --line-buffered --color=never -r "" * | fzf
}
zle -N find-in-file
bindkey '^f' find-in-file
