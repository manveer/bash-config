#########################
## Path configurations ##
#########################
export PATH=/usr/local/bin:$HOME/bin:$PATH

###############
## git stuff ##
###############
alias g="git"
alias gl="git log --decorate --color --graph --pretty=format:'%Cgreen%h%Creset%Cred%d %Creset%s %Cblue(%an, %ar, %cn, %cr)'"
alias gl2="git log --decorate --color --graph --stat --pretty=format:'%Cgreen%h%Creset%Cred%d %Creset%s %Cblue(%an, %ar, %cn, %cr)'"
alias gup="git fetch; git rebase origin/master;"
alias gupw="git fetch; git rebase trunk; arc build;"
alias gpr="git pull --rebase"
parse_git_branch() {
      ref=$(git symbolic-ref -q HEAD 2> /dev/null) || return
        echo " ("${ref#refs/heads/}") \$"
}
## Taken from http://blog.no-panic.at/2011/09/15/my-bash-configuration/
function git_stats {
if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    echo "Number of commits per author:"
    git --no-pager shortlog -sn --all
    AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
    LOGOPTS=""
    if [ "$1" == '-w' ]; then
        LOGOPTS="$LOGOPTS -w"
        shift
    fi
    if [ "$1" == '-M' ]; then
        LOGOPTS="$LOGOPTS -M"
        shift
    fi
    if [ "$1" == '-C' ]; then
        LOGOPTS="$LOGOPTS -C --find-copies-harder"
        shift
    fi
    for a in $AUTHORS
    do
        echo '-------------------'
        echo "Statistics for: $a"
        echo -n "Number of files changed: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
        echo -n "Number of lines added: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
        echo -n "Number of lines deleted: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
        echo -n "Number of merges: "
        git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
    done
else
    echo "you're currently not in a git repository"
fi
}

##########################
## Shell configurations ##
##########################
PS1="";
PS1=$PS1'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
export PS1=$PS1"$GREEN\$(parse_git_branch)$WHITE ";
alias ls='ls -G'
alias grep='grep --color=auto'

###############
## Utilities ##
###############
ulimit -S -n 1024
## no duplicates in bash history
export HISTCONTROL=ignoredups


# Go up directory tree X number of directories
# http://orangesplotch.com/bash-going-up/
function up() {
        COUNTER="$@";
    # default $COUNTER to 1 if it isn't already set
if [[ -z $COUNTER ]]; then
    COUNTER=1
fi
# make sure $COUNTER is a number
if [ $COUNTER -eq $COUNTER 2> /dev/null ]; then
    nwd=`pwd` # Set new working directory (nwd) to current directory
    # Loop $nwd up directory tree one at a time
    until [[ $COUNTER -lt 1 ]]; do
        nwd=`dirname $nwd`
        let COUNTER-=1
    done
    cd $nwd # change directories to the new working directory
else
    # print usage and return error
    echo "usage: up [NUMBER]"
    return 1
fi
}
