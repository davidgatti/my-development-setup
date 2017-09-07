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

	#
	#	Be nice and say something :)
	#
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
}

main