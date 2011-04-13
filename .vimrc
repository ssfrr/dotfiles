" set gVim font
set gfn=Monospace\ 10 

"remove menubar junk from gvim
set guioptions-=m
set guioptions-=T

" set colorscheme
"set t_Co=256
"colorscheme desert256

" change pwd to the directory of the current file
set autochdir
syntax on
set autoindent
set incsearch
set cinoptions=l1
filetype plugin indent on
" make completion more sane
set wildmode=longest,list

" update ctags automatically when source files are written
" au BufWritePost .c,.cpp,*.h silent! !ctags -R &

" try to make sure tab completion works
set nocompatible

" make sure backspace works as expected
set backspace=indent,eol,start

" ignore case in searches
set ignorecase

" set tabbing behavior
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab

" always show status bar
set laststatus=2
" wrap at word boundries(defined by breakat)
set linebreak
" statusline: filename modified read-only separator column, line percentage
set statusline=%t%m%r%=%c,%l\ %P

" set folding options
" set folding to be based off indentation
set foldmethod=indent
" only fold one level deep, for function definitions
set foldnestmax=1
" start with all functions folded
set foldlevel=0
" set to only fold indented blocks more than 2 lines
set foldminlines=2
" set the background to black so it's not so gaudy
highlight Folded ctermbg=black ctermfg=cyan guibg=black
" don't ignore preprocessor lines when deciding where to fold
set foldignore=

set showbreak=@
" set j and k to move down visual lines, not real lines
map j gj
map k gk

" set the underscore as a word delimiter
set iskeyword-=_

"setup ctags stuff
set nocp
filetype plugin on
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
set tags=.tags,.TAGS,tags,TAGS,./tags,../tags,../../tags,../../../tags;
set tags+=~/.vim/tags/em35xtags
set tags+=~/.vim/tags/stm8tags
"set custom syntax highlighting
au BufNewFile,BufRead SCons* setf scons

" set F9,F10 to toggle spellcheck
map <F9> <Esc>:setlocal spell spelllang=en_us<CR>
map <F10> <Esc>:setlocal nospell<CR>

"include other useful scripts
source ~/.vim/hexconvert
