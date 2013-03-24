# Path configurations
export PATH=/usr/local/bin:$HOME/bin:$PATH

## git stuff
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

# Shell configurations
PS1="";
PS1=$PS1'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
export PS1=$PS1"$GREEN\$(parse_git_branch)$WHITE ";
alias ls='ls -G'
alias grep='grep --color=auto'


# Utilities
ulimit -S -n 1024

