# init script for interactive shells
# vim: set ft=sh :

# Zsh 配置文件加载顺序
# zsh 启动过程中会依次读取以下文件：
# 1. /etc/zshenv
# 2. ZDOTDIR/.zshenv（ZDOTDIR 未设置时默认为 $HOME）
# 3. 如果是 login shell，读取 /etc/zprofile, $ZDOTDIR/.zprofile
# 4. 如果是 interactive shell，读取 /etc/zshrc, $ZDOTDIR/.zshrc
# 5. 如果是 login shell，读取 /etc/zlogin, $ZDOTDIR/.zlogin
# +--------------+-------------+-------------+-----------------+-----------------+
# |              |    login    |  non-login  |      login      |    non-login    |
# |              | interactive | interactive | non-interactive | non-interactive |
# +--------------+-------------+-------------+-----------------+-----------------+
# |/etc/zshenv   |     A       |      A      |        A        |        A        |
# +--------------+-------------+-------------+-----------------+-----------------+
# |~/.zshenv     |     B       |      B      |        B        |        B        |
# +--------------+-------------+-------------+-----------------+-----------------+
# |/etc/zprofile |     C       |             |        C        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |~/.zprofile   |     D       |             |        D        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |/etc/zshrc    |     E       |      C      |                 |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |~/.zshrc      |     F       |      D      |                 |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |/etc/zlogin   |     G       |             |        E        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |~/.zlogin     |     H       |             |        F        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |              |             |             |                 |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |              |             |             |                 |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |~/.zlogout    |     I       |             |        G        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+
# |/etc/zlogout  |     J       |             |        H        |                 |
# +--------------+-------------+-------------+-----------------+-----------------+

# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout
#
# If ZDOTDIR is not set, then the value of HOME is used; this is the usual case.
#
# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set. It should contain commands to set the command search path, plus other important environment variables. `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.
#
# `.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'. `.zprofile' is meant as an alternative to `.zlogin' for ksh fans; the two are not intended to be used together, although this could certainly be done if desired.
#
# `.zshrc' is sourced in interactive shells. It should contain commands to set up aliases, functions, options, key bindings, etc.
#
# `.zlogin' is sourced in login shells. It should contain commands that should be executed only in login shells.
# `.zlogin' is not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it should not change the shell environment at all. Rather, it should be used to set the terminal type and run a series of external commands (fortune, msgs, etc).`
#
# `.zlogout' is sourced when login shells exit.

# set in /etc/zshenv
# if [[ -z "$ZDOTDIR" ]]; then
#     export ZDOTDIR="$HOME/.local/zsh"
# fi

# prevent loading twice
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

#----------------------------------------------------------------------
# exit if not bash/zsh, or not in an interactive shell
#----------------------------------------------------------------------
[ -z "$BASH_VERSION" ] && [ -z "$ZSH_VERSION" ] && return
[[ $- != *i* ]] && return

# skip if in non-interactive mode
# case "$-" in
#     *i*) ;;
#     *) return
# esac
