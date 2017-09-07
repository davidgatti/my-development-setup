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
	echo '  ____               _      ___   ______      _     '
	echo ' |  _ \             | |    |__ \ |___  /     | |    '
	echo ' | |_) |  __ _  ___ | |__     ) |   / /  ___ | |__  '
	echo ' |  _ <  / _` |/ __|| '_ /\   / /   / /  / __|| '_ \ '
	echo ' | |_) || (_| |\__ \| | | | / /_  / /__ \__ \| | | |'
	echo ' |____/  \__,_||___/|_| |_||____|/_____||___/|_| |_|'
	echo ''
	echo ''
	printf "${NORMAL}"
}

main