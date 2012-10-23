# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export HISTCONTROL=ignoreboth   # skip space cmds and dupes in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
shopt -s histappend             # append to history instead of overwrite
shopt -s cmdhist                # save multiline cmds in history
shopt -s cdspell                # spellcheck cd

set -o vi                       # use a vi-style command line editing interface
set -o noclobber                # no clobber of files on redirect >| override
shopt -s extglob                # bash extended globbing

export CLICOLOR=1               # colorize ls
export LESS='-X -R -M --shift 5' # LESS no clear on exit, show RAW ANSI, long prompt, move 5 on arrow
export EDITOR=vim               # vim is the only editor
export VISUAL=vim               # vim is the only editor

export MANPAGER="less -X"

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
alias sl=ls
alias lsd='(ls -laF | fgrep "/")'
alias lsdot.='ls -ldF .[a-zA-Z0-9]*'
alias lsx='ls -laF | fgrep "*"'
alias la='ls -Al'               # show hidden files
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'              # sort by change time
alias lu='ls -lur'              # sort by access time
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'          # nice alternative to 'ls'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# hex to decimal and vice-versa
alias h2d='perl -e "printf qq|%d\n|, hex(shift)"'
alias d2h='perl -e "printf qq|%X\n|, int(shift)"'

# datetime aliases
alias today='date +"%A, %B %d, %Y"'
alias yest='date -v-1d +"%A %B %d, %Y"'
alias epoch='date +%s'

alias rot13='tr a-zA-Z n-za-mN-ZA-M'

alias badge="tput bel"

# git
alias g='git'
alias gd='git diff'
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'

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

function ssh-copy-id {
    if [[ -z "$1" ]]; then
        echo "!! You need to enter a hostname in order to send your public key !!"
    else
        echo "* Copying SSH public key to server..."
        ssh ${1} "mkdir -p .ssh && cat - >> .ssh/authorized_keys" < ~/.ssh/id_rsa.pub
        echo "* All done!"
    fi

    ID_FILE="${HOME}/.ssh/id_rsa.pub"

    if [ "-i" = "$1" ]; then
        shift
        # check if we have 2 parameters left, if so the first is the new ID file
        if [ -n "$2" ]; then
            if expr "$1" : ".*\.pub" > /dev/null ; then
                ID_FILE="$1"
            else
                ID_FILE="$1.pub"
            fi
            shift         # and this should leave $1 as the target name
        fi
    else
        if [ x$SSH_AUTH_SOCK != x ] && ssh-add -L >/dev/null 2>&1; then
            GET_ID="$GET_ID ssh-add -L"
        fi
    fi

    if [ -z "`eval $GET_ID`" ] && [ -r "${ID_FILE}" ] ; then
        GET_ID="cat ${ID_FILE}"
    fi

    if [ -z "`eval $GET_ID`" ]; then
        echo "ssh-copy-id: ERROR: No identities found" >&2
        return 1
    fi

    if [ "$#" -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: ssh-copy-id [-i [identity_file]] [user@]machine" >&2
        return 1
    fi

    # strip any trailing colon
    host=`echo $1 | sed 's/:$//'`

    { eval "$GET_ID" ; } | ssh $host "umask 077; test -d ~/.ssh || mkdir ~/.ssh ; cat >> ~/.ssh/authorized_keys" || return 1

    cat <<EOF
Now try logging into the machine, with "ssh '$host'", and check in:

    ~/.ssh/authorized_keys

to make sure we haven't added extra keys that you weren't expecting.

EOF
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

function surootx() {
    xauth list | while read XAUTH ; do
        echo "add $XAUTH" | sudo xauth
        done
        sudo -i
    }

function httpcompression() {
    local encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" |
    grep '^Content-Encoding:')" &&
    echo "$1 is encoded using ${encoding#* }" ||
    echo "$1 is not using any encoding"
}

function dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

function gz() {
    echo "orig size (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

function genpass() {
    local length=${1-8}
    if command -v openssl > /dev/null ; then
        openssl rand -base64 $length | cut -c 1-$length
    else
        local MATRIX="HpZldxsG47f0W9gNaLRTQjhUwnvPtD5eAzr6k@EyumB3@K^cbOCV+SFJoYi2q@MIX81"
        local PASS=""
        local n=1
        while [ ${n} -le $length ]; do
            PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
            n=$(($n + 1))
        done
        echo $PASS
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
        alias preview='open -a Preview'
        alias xcode='open -a Xcode'
        alias filemerge='open -a FileMerge'
        alias safari='open -a Safari'
        alias firefox='open -a Firefox'
        alias chrome='open -a "Google Chrome"'
        alias finder='open -a Finder '
        alias textedit='open -a TextEdit'
        alias hex='open -a "Hex Fiend"'
        alias ldd='otool -L'
        # homebrew
        alias bup='brew update && brew upgrade'
        alias bout='brew outdated'
        alias bin='brew install'
        alias brm='brew uninstall'
        alias bls='brew list'
        alias bsr='brew search'
        alias binf='brew info'
        alias bdr='brew doctor'
        alias md5sum='md5'
        alias sha1sum='shasum'
        source `brew --prefix git`/etc/bash_completion.d/git-completion.bash
        complete -o default -o nospace -F _git g
        function pdfman () {
            man -t $1 | open -a /Applications/Preview.app -f
        }
        function appquit() {
            osascript -e "ignoring application responses" -e "tell application \"$@\" to quit without saving" -e "end ignoring"
        }
        function apprun() {
            open -a $@
        }
        function note() {
            local text
            if [ -t 0 ]; then # argument
                    text="$1"
            else # pipe
                text=$(cat)
            fi
            body=$(echo "$text" | sed -E 's|$|<br>|g')
            osascript >/dev/null <<EOF
            tell application "Notes"
                tell account "iCloud"
                    tell folder "Notes"
                        make new note with properties {name:"$text", body:"$body"}
                    end tell
                end tell
            end tell
EOF
        }

        function remind() {
            local text
            if [ -t 0 ]; then
                text="$1" # argument
            else
                text=$(cat) # pipe
            fi
            osascript >/dev/null <<EOF
                    tell application "Reminders"
                    tell the default list
                        make new reminder with properties {name:"$text"}
                        end tell
                    end tell
EOF
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

