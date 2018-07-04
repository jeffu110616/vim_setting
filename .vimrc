"  VimRC of ShepJeng (t9054@cs.nccu.edu.tw)

set nocompatible
set secure
"set clipboard=unnamed


set backspace=2         " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

set wildchar=<TAB>      " such as <TAB> in shell
set smarttab
set tabstop=4
set shiftwidth=4
let mapleader = "<C-a>" 

set nu
set t_Co=8              " number of colors
set t_Sf=[1;3%p1%dm   " set foreground color
set t_Sb=[1;4%p1%dm   " set background color
set showcmd             " show command
set showmode            " show current mode
set incsearch           " While typing a search pattern, show immediately 
set autoindent


" where the so far typed pattern matches.
set hlsearch            " When there is a previous search pattern, 
	" highlight all its matches.
	syntax on               " show parts of the text in another font or color

	set fileencodings=utf-8,cp936,big5,latin1
	set background=dark

autocmd FileType c,cpp,cc,java call PROG()
autocmd FileType make setlocal noexpandtab

colorscheme default


autocmd BufRead *.py nmap <C-a>c :w<Esc>G:r!python3 %<CR>`.
autocmd BufRead *.sh nmap <C-a>c :w<Esc>G:r!./%<CR>`.

au BufWinLeave * mkview
au BufWinEnter * silent loadview	

inoremap <C-f> <C-O>za
nnoremap <C-f> za
onoremap <C-f> <C-C>za
vnoremap <C-f> zf


function PROG()
	set showmatch
	set nosmartindent
	set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
	set cinoptions=t0
	set number


	"automatic cursor movement
	imap "" ""<left>
	imap () ()<left>
	imap <> <><left>
	imap {} {}<left><CR><CR><UP><TAB>
	nmap `` :wq<CR>
	nmap tt <C-v>:s/train/test/g<CR>:nohl<CR>
	nmap TT <C-v>:s/test/train/g<CR>:nohl<CR>
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
