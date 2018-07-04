set nocompatible 		"	nocompatible with vi
set backspace=2         " 	make backspace work normally, especially in Unix
set encoding=utf8

set viminfo=%,\"100,'10,/50,:100,h,f0,n~/.viminfo
"           | |     |   |   |    | |  + viminfo file path
"           | |     |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |     |   |   |    + disable 'hlsearch' loading viminfo
"           | |     |   |   + command-line history saved
"           | |     |   + search history saved
"           | |     + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

set ruler               " show the cursor position all the time
set wildchar=<TAB>      " such as <TAB> in shell (auto-completion)
set smarttab 			" indent with tab
set tabstop=4 			" the width of a tab
set shiftwidth=4 		" #spaces represented by a tab 		
set noexpandtab 		" not to turn tabs into spaces


set nu 					" display number of lines on the lefthand side
set t_Co=8            " number of colors
set t_Sf=[1;3%p1%dm   " set foreground color
set t_Sb=[1;4%p1%dm   " set background color
set showcmd             " show command
set showmode            " show current mode
set incsearch           " While typing a search pattern, show immediately 
						" where the so far typed pattern matches.
set hlsearch            " When there is a previous search pattern, 
						" highlight all its matches.

	syntax on           " show parts of the text in another font or color
	"colorscheme srcery-drk 

	set fileencodings=utf-8,cp936,big5,latin1
	set background=dark

autocmd FileType c,cpp,cc,java,python call PROG()
autocmd FileType make setlocal noexpandtab
colorscheme default

autocmd BufRead *.py nmap <C-a>c :w<Esc>G:r!python3 %<CR>`.
autocmd BufRead *.sh nmap <C-a>c :w<Esc>G:r!./%<CR>`.

function PROG()
	set showmatch
	set nosmartindent
	set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
	set cinoptions=t0
	set number
	au BufWinLeave * mkview
	au BufWinEnter * silent loadview	

	inoremap <C-f> <C-O>za
	nnoremap <C-f> za
	onoremap <C-f> <C-C>za
	vnoremap <C-f> zf


	"automatic cursor movement
	imap "" ""<left>
	imap () ()<left>
	imap <> <><left>
	imap {} {}<left><CR><CR><UP><TAB>
	nmap `` :wq<CR>
	set formatoptions=tcqr
	endfunction


	set mouse=a
	highlight Comment    ctermfg=DarkCyan
	highlight SpecialKey ctermfg=Yellow

	map <F2> :update<CR>                    " using :update to replace :w
	map <F3> :update<CR>:q<CR>
	map <F4> :q!<CR>
	map <F5> :bp<CR>
	map <F6> :bn<CR>
	" map <F8> :set hls!<BAR>set hls?<CR>     " toggle on/off highlightsearch
	map <F8> :set paste!<BAR>set paste?<CR> " toggle on/off paste mode
	set pastetoggle=<F8>
	map <F9> :!make %:r <CR>

	map <F7> :if exists("syntax_on") <BAR>  " press <F7> syntax on/off
	\   syntax off <bar><cr>
	\ else <BAR>
	\   syntax on <BAR>
	\ endif <CR>

	map <F10> <ESC>:read !date<CR>


	"smart mapping for tab completion
function InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
	return "\<tab>"
	else
	return "\<c-p>"
	endif
	endfunction 

	inoremap <TAB> <C-R>=InsertTabWrapper()<CR>


	set secure 				"	When on, ':autocmd', shell and write commands are not allowed in
	"	'.vimrc' and '.exrc' in the current directory and map commands are
	"	displayed.  Switch it off only if you know that you will not run into
	"	problems, or when the 'exrc' option is off.


