" => General
" keep 100 lines of history
set history=100
if has("autocmd")
	filetype plugin on	" use filetype plugins
	filetype indent on	" use filetype indenting
endif
" read the file back in on external change
set autoread

" => Colors and Fonts
" if terminal supports colors or gui
if &t_Co > 2 || has("gui_running")
	set background=dark	    " must come before colorscheme
	colorscheme solarized	" https://github.com/altercation/vim-colors-solarized
	syntax on
	set hlsearch
endif

" THIS NEEDS FIXED FOR OSX, UNIX, WINDOWS
if has("gui_running")
	set guifont=Source\ Code\ Pro:h13
"	if has("gui_gtk2")
"		set guifont=Inconsolata\ 12
"	elseif has("gui_win32")
"		set guifont=Consolas:h11:cANSI
"	endif
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac

" => VIM ui
set nocompatible	" we are VIM not VI
set laststatus=2	" status is 2 line
set ruler			" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" number lines
set backspace=indent,eol,start	" allow backspacing in insert mode
set showmatch
set mat=2
set lazyredraw
set magic
"set noerrorbells
"set novisualbell
set visualbell

" => Files, backups and undo
" centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
if has("vms")
	set nobackup	" VMS keeps backups
else
	set backup	" backup everywehre else
endif
set backupskip=/tmp/*,/private/tmp/* 

" => Text, tab and indent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set wrap
set autoindent
set smartindent
set autoindent		" always set autoindenting on

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
