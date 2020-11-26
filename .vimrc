"vim settings

set number				"use line number
set relativenumber		"use relative lin number
set hlsearch			"highlight the words found when searching
set backspace=2			"allow vim use backspace to delete characters
set autoindent			"follow the same indent of the line before
set showmode			"show what mode it is right now
set ruler				"show the position of your cursor
set background=dark		"use a dark background
set tabstop=4			"set tab length as 4
set softtabstop=4
set shiftwidth=4		"the width of a indent
set cursorline			"highlight current line
"set textwidth=80		"the maximum width of a line
set nowrap				"do not wrap the text
set showmatch			"highlight the bracket match with the current one
set incsearch			"jump to the first result that match what you
						"search immediately as you input each character
set autoread			"inform me if the file is edit by other programs
						"eg. other editors
set nocompatible		"let vim be vi improved
syntax enable			"support syntax highlight
syntax on				"turn on the syntax highlight
if has('nvim')
	set termguicolors	"use turecolor from console
						"seems not work in vim for unknown reason
endif
colorscheme monokai		"use the color scheme 'monokai'
						"reset some ugly highlight
"highlight MatchParen cterm=bold ctermbg=60 ctermfg=77
"highlight CursorLine ctermbg=0 cterm=NONE
set whichwrap=b,s,h,l,[,]
						"enable the function of changing lines for:
						"1.backspace,whitespace,key-h,key-l in normal/visial
						"  mode
						"2.left,right in insert/replace mode
set clipboard+=unnamedplus

" terminal (work only in vim 8)
fun! ToggleTerminal()
	botright split
	resize 5
	:call term_start('bash',{'curwin':1,'term_finish': 'close'})
endfunc

"autocmd BufWritePost $MYVIMRC source $MYVIMRC

"-- settings for bundles --
 if filereadable(expand('~/.config/nvim/bundles.vim'))
	source ~/.config/nvim/bundles.vim
endif

"-- settings for c/c++ --
if filereadable(expand('~/.config/nvim/csets.vim'))
	source ~/.config/nvim/csets.vim
endif

"-- settings for maps and abbreviations --
if filereadable(expand('~/.config/nvim/maps.vim'))
	source ~/.config/nvim/maps.vim
endif
