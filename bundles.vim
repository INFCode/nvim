"download vim-plug if not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.nvim/plugged')	"run vim-plug, all plugins should be after it
"-----------------------------------
Plug 'vim-scripts/vim-plug'			"let vim-plug manage itself
Plug 'scrooloose/nerdtree'			"NERDTree, help to manage the files
Plug 'Chiel92/vim-autoformat'		"format the code, make it prettier
"Plug 'dense-analysis/ale'			"ale format check
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"									"conqure of completion
Plug 'lervag/vimtex'				"latex support
""Plug 'arcticicestudio/nord-vim'		"load nord colortheme
Plug 'sirver/ultisnips'				"snippets support
Plug 'dhruvasagar/vim-table-mode'   "modify the table in .md file
Plug 'rust-lang/rust.vim'			"rust support
Plug 'crusoexia/vim-monokai'		"monokai color scheme
"Plug 'jiangmiao/auto-pairs'			"pairing the brackets
Plug 'rhysd/accelerated-jk'			"accelerate as j/k is continuously pressed
"Plug 'ludovicchabant/vim-gutentags' "the plugin that makes ctags easier to use
Plug 'yggdroot/indentLine'			"add visible indentlines
"-----------------------------------
call plug#end()					    "stop vim-plug, all plugins should be
									"added before this line

"-- Settings for NERDTree --
let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
"开启/关闭nerdtree快捷键
map <C-f> :NERDTreeToggle<CR>
"let NERDTreeShowBookmarks=1  " 开启Nerdtree时自动显示Bookmarks
"打开vim时如果没有文件自动打开NERDTree
autocmd VimEnter * if !argc()|:NERDTree|endif
"if vim is turned on with a file, put the curser in the file(this command fails)
"autocmd VimEnter * if argc()|<C-w>l|endif
"if NERDTree is the last window,  turn off vim
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | :q | endif
"set the icon used in NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$']  " do not show any .pyc file
let g:NERDTreeShowLineNumbers=0  " show line numbers in nerdtree
let g:NERDTreeHidden=0     " do not show hidden files
"Making NERDTree prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"-- settings for AutoFormat --
let g:autoformat_verbosemode = 0  " silent mode
autocmd BufWrite *.c,*.h,*.cpp,*.hpp :Autoformat	" use autoformate when writing these files
" prefered style in C and C++
let g:formatdef_astyleformat_linux = '"astyle -p -U --style=linux"'
let g:formatters_c = ['astyleformat_linux']
let g:formatters_cpp = ['astyleformat_linux']
" formating rust
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

"-- settings for ale --
"始终开启标志列
let g:ale_sign_column_always = 1
"对于StyleError及StyleWarning不高亮
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
"保存文件时不进行检查（避免保存过于缓慢）
let g:ale_lint_on_save = 0
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\	'vim': ['vint']
\}
"Use <LEADER>g to go to the defination
noremap <LEADER>g :ALEGoToDefinition

"-- settings for coc --
" The settings can be found in coc.vim
call g:LoadConfig(stdpath('config') . "/coc.vim" )

"-- settings for vimtex --

"-- settings for Ultisnips --
" set tab as the key to trigger the expand
let g:UltiSnipsExpandTrigger = '<leader><tab>'
let g:UltiSnipsJumpForwardTrigger = '<leader><tab>'
let g:UltiSnipsJumpBackwardTrigger = '<leader><s-tab>'

"-- settings for ctags --
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
" the name of the tagfile generated
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" put tagsfiles into ~/.cache/tags folder to keep the project folder clean
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
" generate the folder if it does not exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
" parameters of ctags
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

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
