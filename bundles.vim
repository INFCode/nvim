"install vim-plug if not exist
if !filereadable(expand('~/.local/share/nvim/plugged/plug.vim'))
	echo "Vim-Plug not found.\n Downloading ..."
	exec "!sh -c 'curl -fLo ~/.local/share/nvim/plugged/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
	echo "Done."
endif

call plug#begin('~/.local/share/nvim/plugged')	"run vim-plug, all plugins should be after it
"-----------------------------------
Plug 'vim-scripts/vim-plug'			"let vim-plug manage itself
Plug 'scrooloose/nerdtree'			"NERDTree, help to manage the files
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"									"conqure of completion
Plug 'lervag/vimtex'				"latex support
Plug 'dhruvasagar/vim-table-mode'   "modify the table in .md file
Plug 'rust-lang/rust.vim'			"rust support
Plug 'crusoexia/vim-monokai'		"monokai color scheme
"Plug 'jiangmiao/auto-pairs'			"pairing the brackets
Plug 'rhysd/accelerated-jk'			"accelerate as j/k is continuously pressed
Plug 'yggdroot/indentLine'			"add visible indentlines
Plug 'tonyfettes/ccount.vim'		"count words in a file
Plug 'christoomey/vim-tmux-navigator'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'lukas-reineke/indent-blankline.nvim'
"-----------------------------------
call plug#end()					    "stop vim-plug, all plugins should be
									"added before this line

"-- Settings for NERDTree --
let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
"开启/关闭nerdtree快捷键
map <C-n> :NERDTreeToggle<CR>
"let NERDTreeShowBookmarks=1  " 开启Nerdtree时自动显示Bookmarks
"打开vim时如果没有文件自动打开NERDTree
"autocmd VimEnter * if !argc()|:NERDTree|endif
"if vim is turned on with a file, put the curser in the file(this command fails)
"autocmd VimEnter * if argc()|:b#|endif
"if NERDTree is the last window,  turn off vim
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | :q | endif
"set the icon used in NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$']  " do not show any .pyc file
let g:NERDTreeShowLineNumbers=0  " show line numbers in nerdtree
let g:NERDTreeHidden=0     " do not show hidden files
"Making NERDTree prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"-- settings for coc --
" The settings can be found in coc.vim
call g:LoadConfig(stdpath('config') . "/coc.vim" )

"-- settings for vimtex --

" Settings for accelerated-jk
let g:accelerated_jk_acceleration_table = [4, 8, 16, 32]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

let g:AutoPairsMapCh=0

" use monokai
colorscheme monokai		"use the color scheme 'monokai'

" settings for indentLine
let g:indentLine_enabled = 0	" 先关掉
let g:indent_guides_guide_size   = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level  = 2  " 从第二层开始可视化显示缩进

" settings for markdown-preview
" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'firefox'

lua<<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { 'toml' },
	highlight = {
		enable = true,
	},
}
require'indent_blankline'.setup {
	char = '▏'
}
EOF

let g:indent_blankline_max_indent_increase = 1
let g:indent_blankline_char_list = ['▏', '┆', '┊']
let g:indent_blankline_show_first_indent_level = v:false
