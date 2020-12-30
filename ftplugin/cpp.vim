silent !echo "Compile finished."

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

" Compiling a single cpp file
func CompileCpp()
	write
	silent !echo "Compiling C++ file:%..."
	let compilecmd = "!clang++ "
	let compileflag = ""
	silent exec compilecmd." % ".compileflag."-o %<"
	silent !echo "Compile finished."
endfunc

" Compile the file and execute
func CppCompileRun()
	write
	"call the matched program
	if &filetype == "cpp"
		call CompileCpp()
	else
		echo "This file is not a C++ file"
		return
	endif
	"run the executable file which has the same name as the file
	"(the expression '%<' get the source file's name without the
	" extension)
	! ./%<
endfunc
noremap <F5> <ESC> :call CppCompileRun() <CR>

"-- F6 run without compiling again --
" Directly use the RunOnly function that is defined in c.vim
func RunOnly()
endfunc
