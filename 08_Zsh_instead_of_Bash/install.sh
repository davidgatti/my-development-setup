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
	if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
		sudo apt-get -y install zsh
	fi

	#
	#	Clean the memory
	#
	unset CHECK_ZSH_INSTALLED

################################################################################

	#
	#	Remove the previous config file, so we know we start from scratch
	#
	rm -f ~/.zshrc

	#
	#	Removing unnecessary Bash files
	#
	rm -f ~/.bash_history
	rm -f ~/.bash_logout
	rm -f ~/.bashrc
	rm -f ~/.bash_sessions
	rm -f ~/.sh_history
	rm -f ~/.profile

################################################################################

	#
	#	Download the configuration file
	#
	curl -fsSL "https://raw.githubusercontent.com/davidgatti/my-development-setup/master/08_Zsh_instead_of_Bash/zshrc" >> ~/.zshrc

	#
	#	Get the name of the logged in user
	#
	USER_NAME=$(whoami)

	#
	#	Get the home path for the logged in user
	#
	HOME_PATH=$(getent passwd $USER_NAME | cut -d: -f6)

	#
	#	Add a dynamic entry
	#
	echo 'zstyle :compinstall filename '$HOME_PATH/.zshrc'' >> ~/.zshrc

	#
	#	Switch to ZSH
	#
	zsh
}

main
