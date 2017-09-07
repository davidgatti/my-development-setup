main()
{
	#
	#	Use colors, but only if connected to a terminal, and that terminal
	#	supports them.
	#
	if which tput >/dev/null 2>&1; then
			ncolors=$(tput colors)
	fi
	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
		RED="$(tput setaf 1)"
		GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		NORMAL="$(tput sgr0)"
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		NORMAL=""
	fi

	#
	#	Only enable exit-on-error after the non-critical colorization stuff,
	#	which may fail on systems lacking tput or terminfo
	#
	set -e

	#
	#	Be nice and say something :)
	#
	printf "${GREEN}"
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