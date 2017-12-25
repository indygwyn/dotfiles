# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
	# This is bad, only do this on OSX cause OSX every shell is a login shell
	. ~/.bashrc
fi
# User specific environment and startup programs
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH:$HOME/bin:/Library/Application\ Support/MultiMarkdown/bin:/opt/X11/bin


export NARWHAL_ENGINE=jsc

export PATH="/Users/twh/narwhal/bin:$PATH"

export CAPP_BUILD="/Users/twh/Build"
