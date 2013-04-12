set nocp

" invoke pathogen
call pathogen#infect()
" make sure help docs work
Helptags

" make sure vim knows our terminal is 256-capable (gnome-terminal doesn't
" report itself as such)
set t_Co=256
colorscheme molokai

syntax on

set autochdir

filetype indent on

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

set tags=.tags,.TAGS,tags,TAGS,./tags,../tags,../../tags,../../../tags;

" set F9,F10 to toggle spellcheck
map <F9> <Esc>:setlocal spell spelllang=en_us<CR>
map <F10> <Esc>:setlocal nospell<CR>

" set F11 to list the syntax highlighting rules under the cursor
map <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" janus tries to steal ctrl-T to run the ctrlp browser
map <c-t> :pop<CR>

" make enter clear search highlighting, resync syntax hilightlighting and recalculate folds
nnoremap <silent> <CR> :noh<CR>:syntax sync fromstart<CR>:set foldmethod=indent<CR>

" Now we can change indentation without losing selection
vnoremap < <gv
vnoremap > >gv

"override smartcase
set ignorecase

" ignore case in filename completion, even on platforms that are case
" sensitive
set wildignorecase

so ~/.scvimrc

" set ctrlp to open in vertical split by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-o>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-h>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<cr>', '<RightMouse>'],
    \ }
