"vim settings

set number				"use line number
set relativenumber		"use relative line number
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
set inccommand=nosplit	"show the effects of commands incrimentally
syntax enable			"support syntax highlight
syntax on				"turn on the syntax highlight
if has('nvim')
	set termguicolors	"use turecolor from console
						"seems not work in vim for unknown reason
endif
						"reset some ugly highlight
"highlight MatchParen cterm=bold ctermbg=60 ctermfg=77
"highlight CursorLine ctermbg=0 cterm=NONE
set whichwrap=b,s,h,l,[,]
						"enable the function of changing lines for:
						"1.backspace,whitespace,key-h,key-l in normal/visial
						"  mode
						"2.left,right in insert/replace mode
set clipboard+=unnamedplus

set hidden				"allow to hide a modified buffer

set mouse=a				"enable mouse support

filetype plugin indent on
						" filetype specific support
let mapleader = "'"     "set leader as '

" terminal (work only in vim 8)
fun! ToggleTerminal()
	botright split
	resize 5
	:call term_start('bash',{'curwin':1,'term_finish': 'close'})
endfunc

" support for OCaml ocp-indent
set rtp^="/home/infcode/.opam/eecs490/share/ocp-indent/vim"

"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Load configs in other files
" The loading function
func! g:LoadConfig(filename)
	if filereadable(expand(a:filename))
		exec "source ". a:filename
	else
		echo "Config file " . a:filename . " not found."
	endif
endfunc

" the list for all config files
let configFiles = [
	\stdpath('config') . '/bundles.vim',
	\stdpath('config') . '/maps.vim',
	\]

for b:filename in configFiles
	call g:LoadConfig(b:filename)
endfor
