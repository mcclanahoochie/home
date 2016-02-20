# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# alias
alias ls='ls -1 --color'
alias l='ls'
alias ll='ls -lh'
alias lrt='ls -rt'
alias llrt='ls -lrt'
alias la='ls -A'
alias lla='ls -lA'
alias ..='cd ..'
alias -- -='cd -'
alias g=git
alias gi=git
alias gitinfo='git show | head -3 && git remote -v'
alias grep="grep --color"
alias ~='cd ~'
alias m="matlab -nojvm -nosplash"
alias M="matlab -nodesktop -nosplash"

# workspace
alias w='cd ~/workspace/c1_vr2.0'

# functions
h()        { history | tail -15; }
line()     { sed "$1q;d" $2; }
rmline()   { sed -i'' -e "$1d" $2; }
buffer()   { (test -t 1 && less -F - || cat) } # stdin to less if terminal
tmpdir()   { pushd `mktemp -d -t tmpXXX`; }
mkcd()     { mkdir $@ && cd $@; }
calc()     { echo "$@" | bc -l; }
mdb()      { matlab -Dgdb; }
dos2unix() { sed 's/\o15//g' -i $@; }
gdbtool () { emacs --eval "(gdb \"gdb -i=mi $*\")";}

# less
export LESS="-irmXF"
export LESSOPEN="|lesspipe.sh %s"  # special less file hooks
export LESSCLOSE=

# arch
if [[ `uname -m` == x86_64 ]]; then ARCH=64; fi
if [[ `uname` == Darwin ]]; then  alias ls='ls -1G'; fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# timestap history
export HISTFILE=~/.bash_history
echo "# $(date)" >>$HISTFILE
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export HISTCONTROL=ignoreboth # Don't store duplicate adjacent items in the history
shopt -s histappend
export PROMPT_COMMAND="history -a && history -r" # each cmd updates hist

# GIT PS1 and auto complete
if [ -r ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
else
    function __git_ps1() { true; }
fi

# prompt
export PS1='\[\e[33m\]\h\[\e[0m\].\[\033[32m\]\W\[\033[0m\]$(__git_ps1 "{%s}") \$ '
set visual-bell none

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# setup PATH (top of list is highest precedence)
[[ `uname` =~ CYGWIN.* ]] || PATH=   # windows already set PATH
for p in \
    /usr/local/bin \
    /usr/local/sbin \
    /opt/local/bin \
    /opt/local/sbin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin \
    /usr/local/matlab/bin \
    /usr/local/cuda/bin \
    ; do
  [ -x $p ] && PATH=$PATH:$p
done
unset p
export PATH=${PATH##:}

# editors
export PAGER=less
export VISUAL=nano
export EDITOR=nano
export ALTERNATE_EDITOR=nano

# paths
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib/:$LD_LIBRARY_PATH

# up-arrow-history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# mac
export PATH=${PATH}:/Developer/usr/bin/
export PATH=${PATH}:/usr/bin/

# android
export ANDROID_SDK=/Users/chris/workspace/adt-bundle-mac-x86_64/sdk
export ANDROID_NDK=/Users/chris/workspace/android-ndk-r10d
export PATH=${PATH}:${ANDROID_SDK}/platform-tools
export PATH=${PATH}:${ANDROID_SDK}/tools
export PATH=${PATH}:${ANDROID_NDK}
export NDKROOT=${ANDROID_NDK}
export NDK_HOME=${ANDROID_NDK}

# emacs
alias aquamacs='open /Applications/Aquamacs.app/'

# python
PYTHONPATH="/Library/Python/2.7/site-packages/:$PYTHONPATH"
export PYTHONPATH
