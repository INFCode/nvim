"vim config for latex

" set tab 
setlocal shiftwidth=2
setlocal tabstop=2

" consider the .tex file as latex file as default
let g:tex_flavor = 'latex'

" hide latex expressions that are not in the current line
set conceallevel=1

" the default conceal highlight is ugly. reset it.
highlight clear Conceal
highlight Conceal cterm=bold ctermfg=3
let g:vimtex_quickfix_mode=0

" wrap the text so that it can be read more easily
set wrap 

" conceal anything that is not in the current line
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_latexmk = {
  \ 'executable': 'latexmk',
  \ 'options' : [
  \   '-xelatex',
  \   '-verbose',
  \   '-file-line-error',
  \   '-synctex=1',
  \   '-interaction=nonstopmode',
  \ ],
  \}
