main()
{
	#
	#	By default we assume the terminal doesn't support colors
	#
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	BOLD=""
	NORMAL=""

	#
	#	Check  if we are connected to a terminal, and that terminal
	#	supports colors.
	#
	if which tput >/dev/null 2>&1; then
			ncolors=$(tput colors)
	fi

	#
	#	Set the colors if we can
	#
	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
		RED="$(tput setaf 1)"
		GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		NORMAL="$(tput sgr0)"
	fi

	#
	#	Only enable exit-on-error after the non-critical colorization stuff,
	#	which may fail on systems lacking tput or terminfo
	#
	set -e

################################################################################

	printf "${YELLOW}"
	echo ''
	echo '    ____             __   ___  _____        __  '
	echo '   / __ )____ ______/ /_ |__ \/__  /  _____/ /_ '
	echo '  / __  / __ `/ ___/ __ \__/ /  / /  / ___/ __ \'
	echo ' / /_/ / /_/ (__  ) / / / __/  / /__(__  ) / / /'
	echo '/_____/\__,_/____/_/ /_/____/ /____/____/_/ /_/ '
	echo ''
	echo ''
	printf "${NORMAL}"

################################################################################

	#
	#	Find out if Zsh is already installed
	#
	CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)

	#
	#	Check to see if Zsh is already installed
	#
	if [ !$CHECK_ZSH_INSTALLED -ge 1 ]; then
		sudo apt-get -y install zsh
	fi

	#
	#	Clean the memory
	#
	unset CHECK_ZSH_INSTALLED

################################################################################

	#
	#	Create the .zshrc file and add all the settings
	#
	echo 'HISTFILE=~/.histfile' >> ~/.zshrc
	echo 'HISTSIZE=1000' >> ~/.zshrc
	echo 'SAVEHIST=1000' >> ~/.zshrc
	echo 'bindkey -v' >> ~/.zshrc
	echo 'zstyle :compinstall filename '/home/davidgatti/.zshrc'' >> ~/.zshrc
	echo 'autoload -Uz compinit' >> ~/.zshrc
	echo 'compinit' >> ~/.zshrc
	echo "PROMPT='%F{red}%n%f // %F{blue}%m%f // %F{yellow}%1~%f : '" >> ~/.zshrc

################################################################################

	#
	#	Enable Zsh as the default login shell
	#
	chsh -s /bin/zsh

}

main