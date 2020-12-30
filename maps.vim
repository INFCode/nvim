"set leader as ;
let mapleader = '"'

"turn the word into upper case
inoremap <leader>u <esc>bgUwea
"open file .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC.maps<CR>

"use jk as esc
inoremap jk <esc>
"stop using esc itself(use jk instead)
"inoremap <esc> <nop>

"stop using direction keys in any mode (switch to normal mode and use hjkl instead) 
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

"set ctrl+hjkl to make short term move in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"use backspace in normal mode to delete
nnoremap <bs> i<bs>

"-- Abbreviations for C/C++ programs --
iabbrev mian main
iabbrev ture true
iabbrev usingn using namespace std;

"-- maps for Rust --
nmap <leader>f :Autoformat<CR>
