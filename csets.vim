" --New .h .c .cpp .hpp files, add file headers--
"autocmd BufNewFile *.c,*.h,*.cpp,*.hpp :call FileHeader()
func FileHeader()
	let linenum = 0
	let linenum+=1|call setline(linenum,"// File:	".expand('%'))
	let linenum+=1|call setline(linenum,"// Author:	INFCode (INFCode@163.com)")
	let linenum+=1|call setline(linenum,"// Date:	".strftime("%Y/%m/%d %H:%M:%S"))
	let linenum+=1|call setline(linenum,"")
	exec "$"
endfunc

"-- F5 compile and run code --
func CompileC()
	write
	silent !echo "Compiling C file:%..."
	let compilecmd = "!clang "
	if search("math\.h") != 0
		let compileflag .= "-lm"
	endif
	silent exec compilecmd." % ".compileflag."-o %<"
	silent !echo "Compile finished."
endfunc

func CompileCpp()
	write
	silent !echo "Compiling C++ file:%..."
	let compilecmd = "!clang++ "
	let compileflag = ""
	silent exec compilecmd." % ".compileflag."-o %<"
	silent !echo "Compile finished."
endfunc

func CompileRun()
	write
	"call the matched program
	if &filetype == "c"
		call CompileC()
	elseif &filetype == "cpp"
		call CompileCpp()
	else
		echo "This file is not a C/C++ file"
		return
	endif
	"run the executable file which has the same name as the file
	"(the expression '%<' get the source file's name without the
	" extension)
	! ./%<
endfunc
map <F5> <ESC> :call CompileRun() <CR>


"-- F6 run without compiling again --
func RunWithoutCompile()
	let execfilename =expand("%:h")."/".expand("%:t:r") 
	if filereadable(execfilename)
		"run it
		! ./%<
	else
		echo "File ".execfilename." not found."
	endif
endfunc
map <F6> <ESC> :call RunWithoutCompile() <CR>

autocmd BufNewFile,BufRead *.h UltiSnipsAddFiletypes h.c
