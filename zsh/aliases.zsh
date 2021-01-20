alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alh'
alias l='ll -A'
alias lm='l | less'
alias lr='ll -R'
alias lt='ll -tr'
alias lx='ll -X'
alias l.='ls -lF -d .* --color=auto'
# List the 10 most recently edited/changed files (m = more, a poor-man’s more)
alias lsm='ls -lt | head -n 10'

# File handling
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
alias rmr='rm -ivr'
alias mv='mv -iv'
alias cp='cp -iv'
alias cpr='cp -ivr'
alias ln='ln -iv'
alias mkdir='mkdir -pv'
alias mkcd='_(){ mkdir -p $1; cd $1; }; _'

alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias chgrp='chgrp --preserve-root -v'

alias df='df -h'
alias du='du -h'
alias dud='du -ch -d 1'

alias findd='find . -type d -name '
alias findf='find . -type f -name '
alias fd=fdfind

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias h='history'
alias hgrep="fc -El 0 | grep"

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

alias sortnr='sort -n -r'
alias cdiff='colordiff'
alias mount='mount |column -t'
alias j='jobs -l'
alias c='clear'
alias lg='lazygit'
alias ping='ping -c 5'
alias wget='wget -c'
alias bc='bc -l'
alias root='sudo -i'
alias su='sudo -i'
# repeating the last command but using sudo
alias please='sudo $(fc -ln -1)'
alias path='echo -e ${PATH//:/\n}'
alias wl='wc -l'
alias tree='tree -C'

alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
# alias -g P="2>&1| pygmentize -l pytb"

#if dir,cd into it. if file ,cd into where the file is
goto(){ [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

mktar(){ tar cvf  "${1%%/}.tar" "${1%%/}/"; }
mktgz(){ tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }
mktbz(){ tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# ex - archive extractor
# usage: ex <file>
ex ()
{
    if [[ "$#" -lt 1 ]]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        return 1 #not enough args
    fi

    DESTDIR="."

    if [ -f $1 ] ; then
        case $1 in
            *.tar)
                echo -e "Extracting $1 to $DESTDIR: (uncompressed tar)"
                tar xf "$1" -C "$DESTDIR"
                ;;
            *.tar.bz2)
                echo -e "Extracting $1 to $DESTDIR: (bzip compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.tar.gz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xzf "$1" -C "$DESTDIR"
                ;;
            *.bz2)
                echo -e "Extracting $1 to $DESTDIR: (bzip compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.gz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xfz "$1" -C "$DESTDIR"
                ;;
            *.tgz)
                echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
                tar xfz "$1" -C "$DESTDIR"
                ;;
            *.xz)
                echo -e "Extracting  $1 to $DESTDIR: (gip compressed tar)"
                tar xf -J "$1" -C "$DESTDIR"
                ;;
            *.tbz2)
                echo -e "Extracting $1 to $DESTDIR: (tbz2 compressed tar)"
                tar xjf "$1" -C "$DESTDIR"
                ;;
            *.zip)
                echo -e "Extracting $1 to $DESTDIR: (zip compressed file)"
                unzip "$1" -d "$DESTDIR"
                ;;
            *.rar)
                echo -e "Extracting $1 to $DESTDIR: (rar compressed file)"
                unrar x "$1" "$DESTDIR"
                ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# get='wget --continue --progress=bar --timestamping'
# globurl='noglob urlglobber '
