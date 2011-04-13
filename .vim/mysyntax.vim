augroup syntax
au! BufNewFile,BufReadPost *.m                          "get rid of old Matlab binding
au  BufNewFile,BufReadPost *.m so ~/.vim/octave.vim     "and use octave binding
augroup END
