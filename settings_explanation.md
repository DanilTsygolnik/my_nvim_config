```
" Expand TABs to spaces.
set expandtab

" Manual indents (type `>>`) will have a width of 4 spaces.
" more info on indents https://stackoverflow.com/a/5212123
set shiftwidth=4

" A <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" <BS> will delete a 'shiftwidth' worth of space at the start of the line.
set smarttab

" Turn on autoindent
" Use the indent from the previous line while editing.
set autoindent
" Recognizes syntax indents for the languages in `/usr/share/vim/vim82/indent/`.
set smartindent
" Stricter indentation rules for C programs.
set cindent


" Use backspace in Insert mode as in usual text editors
" https://til.hashrocket.com/posts/f5531b6da0-backspace-options
set backspace=indent,eol,start


" Enable the use of the mouse in all modes.
set mouse=a
```

