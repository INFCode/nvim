"turn the word into upper case
noremap <leader>u bgUwea<esc>
inoremap <leader>u <esc>bgUwea

"use jk as esc
inoremap jk <esc>
"use leader h to remove highlight
noremap <leader>h :nohl<CR>

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
