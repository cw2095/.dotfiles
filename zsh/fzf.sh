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
  fd --hidden --follow -E ".git" -E "node_modules" -E "~/GitHub" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow -E ".git" -E "node_modules" -E "~/GitHub" . "$1"
}

if [[ -n "$ZSH_VERSION" ]]; then

_fzf_fpath=${0:h}/fzf
fpath+=$_fzf_fpath
autoload -U $_fzf_fpath/*(.:t)
unset _fzf_fpath

# fzf-tab settings
local extract="
# trim input(what you select)
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"

# The preview command used by fzf-tab (show file or directory contents on completion)
zstyle ':fzf-tab:complete:*:*' extra-opts --preview=$extract'(bat --color=always --pager=never ${realpath} || colorls --color=always --long -A --sort-dirs --git-status ${realpath}) 2>/dev/null'

# Whether to automatically insert a space after the result.
zstyle ':fzf-tab:*' insert-space false
enable-fzf-tab

fi
