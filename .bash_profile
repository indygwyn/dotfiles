# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# User specific environment and startup programs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin:/Library/Application\ Support/MultiMarkdown/bin:/opt/X11/bin:/Applications/ConTeXt/tex/texmf-osx-64/bin
export ARCHFLAGS="-arch x86_64"
export NODE_PATH="/usr/local/lib/node_modules"
