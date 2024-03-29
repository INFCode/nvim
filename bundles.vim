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
Plug 'preservim/vim-pencil'			"provide soft & hard warpping which is helpful for writing in vim
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'} " R support
Plug 'airblade/vim-gitgutter'		" git diff display
Plug 'untitled-ai/jupyter_ascending.vim' " jupyter support
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
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
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

"-- maps for vim-autoformat--
"nmap <leader>f :Autoformat<CR>

"-- vim-gitgutter --
let g:gitgutter_sign_removed = '-'

let g:OmniSharp_server_use_mono = 1

" -- vim-pencil
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init({'wrap': 'hard'})
augroup END
