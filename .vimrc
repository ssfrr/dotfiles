scriptencoding utf-8

set nocp

" ignore warning on from module import *,
" long lines, and semicolons/multiple statements
" note that this MUST be set before pathogen is invoked
" E261 - expects at least 2 spaces before inline comment
" E131 - continuation line unaligned for hanging indent
let g:pymode_lint_ignore = "W0401,E702,E261,E131"
let g:pymode_lint_checker = "pyflakes,pep8"

" invoke pathogen
call pathogen#infect()
" make sure help docs work
Helptags

set t_Co=256
"set background=dark
colorscheme molokai
let g:molokai_original = 1

syntax on

"set autochdir

filetype indent on
filetype plugin on

" set the mapleader key to be more convenient
let mapleader = ";"

" maintain more context when scrolling
set scrolloff=3

" make searching more interactive
set hlsearch
set incsearch

" fix backspace on cygwin
set bs=2

" enable mouse selection stuff
set mouse=a

" set yanking buffer to the system clipboard
set clipboard=unnamed

" set tabbing behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" set folding options
" set folding to be based off indentation
set foldmethod=indent
" only fold one level deep, for function definitions
set foldnestmax=1
" start with all functions folded
set foldlevel=0
" set to only fold indented blocks more than 2 lines
set foldminlines=2
set foldignore=

set showbreak=@

" make completion more sane
set wildmode=longest,list

" set j and k to move down visual lines, not real lines
map j gj
map k gk

set tags=.tags,.TAGS,tags,TAGS,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags;

" set F9,F10 to toggle spellcheck
map <F9> <Esc>:setlocal spell spelllang=en_us<CR>
map <F10> <Esc>:setlocal nospell<CR>

" set F8 to list the syntax highlighting rules under the cursor
map <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" make enter clear search highlighting, resync syntax hilightlighting and
" recalculate folds, unless we're in a quickfix window where we want to
" select the error under the cursor
function! HandleReturn()
    if &buftype ==# "quickfix"
        .cc
    else
        syntax sync fromstart
        set foldmethod=indent
    endif
endfunction

"noh doesn't work from inside a function, so we run it here
nnoremap <silent> <CR> :noh<CR>:call HandleReturn()<CR>

" nmap <C-k> :w<CR>:!rake test:delta 2>&1 \| tee errors.err<CR>
nmap <C-q> :cfile<CR>:copen<CR><C-w>k

" Eval mapping for editing clojure code
vmap <S-E> :Eval<CR>

" Now we can change indentation without losing selection
vnoremap < <gv
vnoremap > >gv

vmap <leader>tp :<C-u>AlignCtrl --ll:<CR>gv:Align " "<CR>

"override smartcase
set ignorecase

" ignore case in filename completion, even on platforms that are case
" sensitive
set wildignorecase
" ignore binary files in filename completion (and ctrlP indexing)
set wildignore+=*.so,*.swp,*.zip,*.o,*.obj

" set ctrlp to open in vertical split by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-o>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-h>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
    \ }

" put a dot for trailing whitespace
set list listchars=tab:→\ ,trail:·
set list

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au BufRead,BufNewFile *.zsh-theme set filetype=zsh

" treat Arduino files as C++ source
au BufRead,BufNewFile *.ino set filetype=cpp

" prefer OpenCL to common lisp for .cl files
au BufRead,BufNewFile *.cl set filetype=opencl

set laststatus=2
" explanation of why the colors are reversed in StatusLine highlight group
" http://vim.1045645.n5.nabble.com/highlight-with-transparent-background-td3386522.html
"User1 is used on the prompt for status flags. Color is matched for molokai
hi User1 ctermfg=118 ctermbg=238
set statusline=%t\ [%{&ff}]\ %y\ %1*%h%m%r%*%=%4.l\ /%4.L,\ %3.c\ \ %3.P

" highlight any characters that are over the desired line width
"au BufRead,BufNewFile *.py highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"au BufRead,BufNewFile *.py match OverLength /\%80v.\+/

"disable line numbering, which is enabled by the python plugin
set nonumber

" close the preview window when completion is done
autocmd CompleteDone * pclose

" Setup backup location and enable
set directory=$HOME/.vim/swp/     "this  is for swp   files

" set horizontal splits to be below the current window, this is particularly
" helpful with the preview window, which otherwise annoyingly moves the
" current content down
set splitbelow
set splitright
