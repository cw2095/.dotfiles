export FZF_DEFAULT_COMMAND='fd --hidden --follow -E ".git" -E "node_modules" . '
# export FZF_DEFAULT_OPTS="--bind 'ctrl-v:execute(nvim {})+abort,ctrl-p:toggle-preview,alt-a:select-all,alt-d:deselect-all' --layout=reverse --tiebreak=index --cycle --preview-window noborder"
export FZF_DEFAULT_OPTS="--bind 'ctrl-p:toggle-preview,alt-a:select-all,alt-d:deselect-all' --layout=reverse --tiebreak=index --cycle --preview-window noborder"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=dark,fg:7,bg:-1,hl:5,fg+:15,bg+:8,hl+:13,info:2,prompt:4,pointer:1,marker:3,spinner:4,header:4"
export FZF_COMPLETION_TRIGGER='\'

export FZF_TMUX=1
export FZF_TMUX_HEIGHT='80%'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow -E ".git" -E "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow -E ".git" -E "node_modules" . "$1"
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
bindkey '^f' fzf-find-widget

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
bindkey '^h' fzf-history-widget

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

find-in-file() {
    grep --line-buffered --color=never -r "" * | fzf
}
zle -N find-in-file
bindkey '^s' find-in-file

