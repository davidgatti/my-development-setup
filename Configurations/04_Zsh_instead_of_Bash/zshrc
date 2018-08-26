# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/davidgatti/.zshrc'
autoload -Uz compinit
compinit

#
#	Add the Bin folder where we keep our custom Bash Scripts
#
export PATH=$PATH:~/.bin

#
#	Enable basic mouse support
#
alias nano='nano --mouse'

#
#	Add the functionality to hit ctrl+r to search CLI history
#
bindkey "^R" history-incremental-search-backward

#
#	If the PROMPT_SUBST option is set, the prompt string is first subjected to
# 	parameter expansion, command substitution and arithmetic expansion.
#
setopt PROMPT_SUBST

#
#	This function will try to get the active branch if a git repo is found
#
function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

PROMPT=' > [%F{yellow}%n%f] [%F{yellow}%m%f] [%F{yellow}%1~%f] [%F{yellow}$(parse_git_branch)%f]: '
