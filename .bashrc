export HISTCONTROL=ignoreboth	# skip space cmds and dupes in history
shopt -s histappend		# append to history instead of overwrite
shopt -s cmdhist		# save multiline cmds in history
shopt -s cdspell		# spellcheck cd
set -o vi			# use a vi-style command line editing interface
set -o noclobber		# no clobber of files on redirect >| override
shopt -s extglob		# bash extended globbing

export CLICOLOR=1		# colorize ls
export LESS='-X -R -M --shift 5' # LESS no clear on exit, show RAW ANSI, long prompt, move 5 on arrow
export EDITOR=/usr/bin/vim	# vim is the only editor

alias idle='while true ; do uname -a ; uptime ; sleep 30 ; done'
alias openports='sudo lsof -i -P'
alias syslog='less +G /var/log/messages'
alias ipsort='sort  -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'
alias h='history | less'

# Job aliases
alias j='jobs -l'
alias 1='%1'
alias 2='%2'
alias 3='%3'
alias 4='%4'
alias 5='%5'
alias 6='%6'
alias 7='%7'
alias 8='%8'
alias 9='%9'

# ls aliases
alias lsd='(ls -laF | fgrep "/")'
alias lsdot.='ls -ldF .[a-zA-Z0-9]*'
alias lsx='ls -laF | fgrep "*"'
alias la='ls -Al'               # show hidden files
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time  
alias lu='ls -lur'		# sort by access time   
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'		# nice alternative to 'ls'

# hex to decimal and vice-versa
alias h2d='perl -e "printf qq|%d\n|, hex(shift)"'
alias d2h='perl -e "printf qq|%X\n|, int(shift)"'

# datetime aliases
alias today='date +"%A, %B %d, %Y"'
alias yest='date -v-1d +"%A %B %d, %Y"'
alias epoch='date +%s'

# git
alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'

export PROMPT_COMMAND=bashprompt # use the bashprompt function to set prompts
function bashprompt {
	history -a
	# A styles
	local Abold="\[\e[1\]"
	local Aunderline="\[\e[4m\]"
	local Ablink="\[\e[5m\]"
	local Areverse="\[\e[7m\]"
	local Aconcealed="\[\e[8m\]"
	# A colors
	local Adefault="\[\e[0;39m\]"
	local Ablack="\[\e[0;30m\]"
	local Ared="\[\e[0;31m\]"
	local Agreen="\[\e[0;32m\]"
	local Ayellow="\[\e[0;33m\]"
	local Ablue="\[\e[0;34m\]"
	local Amagenta="\[\e[0;35m\]"
	local Acyan="\[\e[0;36m\]"
	local Awhite="\[\e[0;37m\]"
	local Agray="\[\e[1;30m\]"
	local Abrightred="\[\e[1;31m\]"
	local Abrightgreen="\[\e[1;32m\]"
	local Abrightyellow="\[\e[1;33m\]"
	local Ablue="\[\e[1;34m\]"
	local Abrightmagenta="\[\e[1;35m\]"
	local Abrightcyan="\[\e[1;36m\]"
	local Abrightwhite="\[\e[1;37m\]"
	# A background colors
	local Aon_black="\[\e[40m\]"
	local Aon_red="\[\e[41m\]"
	local Aon_green="\[\e[42m\]"
	local Aon_yellow="\[\e[43m\]"
	local Aon_blue="\[\e[44m\]"
	local Aon_magenta="\[\e[45m\]"
	local Aon_cyan="\[\e[46m\]"
	local Aon_white="\[\e[47m\]"
	case $TERM in
		@(ansi|xterm)*)
			# Change Terminal TITLE with ANSI
			TITLEBAR='\[\e]0;\u@\h:\w\007\]'
			;;
		*)
			TITLEBAR=""
			;;
	esac
	PS1="${TITLEBAR}$Ablue[$Abrightred\t$Ablue]$Ablue[$Amagenta\l$Ablue:$Acyan\u$Awhite@$Ayellow\h$Ablue:$Acyan\w$Ablue]$Ablue[$Ayellow\j$Ablue]$Ablue[$Acyan\!$Ablue]$Ayellow\$$Adefault "
	PS2='> '
	PS4='+ '
}

function solve () { 
	echo "$*" | bc -l; 
}

function fromepoch {
	perl -e "require 'ctime.pl'; print &ctime($1);"
}

function historyawk() { 
	history | 
	awk '{a[$2]++}END{for(i in a){printf"%5d\t%s\n",a[i],i}}' |
	sort -nr |
	head; 
}

function autoCompleteHostname() { 
	local hosts
	local cur
	hosts=($(awk '{print $1}' ~/.ssh/known_hosts | cut -d, -f1))
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=($(compgen -W '${hosts[@]}' -- $cur )) 
} 
complete -F autoCompleteHostname ssh # ssh autocomplete function

function repeat () { 
	local count="$1" i
	shift
	for i in $(seq 1 "$count"); do 
		eval "$@"
	done
}

function seqx () {
	local lower upper output
	lower=$1 upper=$2
	while [ $lower -le $upper ]; do
		output="$output $lower"
		lower=$[ $lower + 1 ]
	done
	echo $output
}

function ip2hex () {
	local ip=$1
	echo $ip | 
	awk -F. '{ for ( i=1; i<=NF; ++i ) printf ("%02x", $i % 256); print "" }'
}

function spinner () {
	i=1
	sp="/-\|"
	echo -n ' '
	while true ; do
		echo -en "\b${sp:i++%${#sp}:1}"
	done
}

# THESE NEED COMBINED INTO SINGLE FUNCTION AND FIX REMOTE PERMS
function scpdsa {
	if [[ -z "$1" ]]; then
		echo "!! You need to enter a hostname in order to send your public key !!" 
	else
		echo "* Copying SSH public key to server..." 
		ssh ${1} "mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys" < ~/.ssh/id_dsa.pub
		echo "* All done!"
	fi
}

function scprsa {
	if [[ -z "$1" ]]; then
		echo "!! You need to enter a hostname in order to send your public key !!" 
	else
		echo "* Copying SSH public key to server..." 
		ssh ${1} "mkdir -p .ssh && cat - >> .ssh/authorized_keys" < ~/.ssh/id_rsa.pub
		echo "* All done!"
	fi
}

function chr() {
	printf \\$(printf '%03o' $1)
}
	 
function ord() {
	printf '%d' "'$1"
}

function ip2origin() {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 IP"
	else
		ipary=(${1//./ })
		dig +short ${ipary[3]}.${ipary[2]}.${ipary[1]}.${ipary[0]}.origin.asn.cymru.com TXT
	fi
}

function ip2peer() {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 IP"
	else
		ipary=(${1//./ })
		dig +short ${ipary[3]}.${ipary[2]}.${ipary[1]}.${ipary[0]}.peer.asn.cymru.com TXT
	fi
}

function asninfo() {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 AS#####"
	else
		dig +short $1.asn.cymru.com TXT
	fi
}

# Platform Specific Aliases here
case $OSTYPE in
	darwin*)
		alias eject='hdiutil eject'
		alias apinfo='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I'
		alias cpwd='pwd|xargs echo -n|pbcopy'
		alias flushdns='dscacheutil -flushcache'
		alias locate='mdfind -name'
		alias ql='qlmanage -p "$@" >& /dev/null' # Quick Look alias
		function pdfman () {
			man -t $1 | open -a /Applications/Preview.app -f
		}
		function appquit() {
			osascript -e "ignoring application responses" -e "tell application \"$@\" to quit without saving" -e "end ignoring"
		}
		function apprun() {
			open -a $@
		}
	;;
	solaris*)
		export TERM=vt100
	;;
	linux*)
	;;
	netbsd)
	;;
	FreeBSD)
	;;
esac

