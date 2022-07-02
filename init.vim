set encoding=utf-8  " File encoding for writing
set fileencodings=utf-8,cp1251,utf-16le  " File encodings for reading


" Interface settings
set number
set scrolloff=7
set mouse=a
set splitright
set splitbelow

" Keyboard settings
" Назначаем русские буквы соотв. кнопкам английской раскладки
set keymap=russian-jcukenwin
set iminsert=0 " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0 " Чтобы при старте поиск был на английском, а не русском (start > /)
" Кастомный hotkey для переключения раскладок
inoremap <C-l> <C-^>


" Text editing settings

set backspace=indent,eol,start

set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set cindent
set fileformat=unix
filetype indent on " explanation https://vi.stackexchange.com/a/10125

syntax on
let g:markdown_fenced_languages = ['vim', 'bash', 'html', 'python', 'c']

" Pattern search improvements
set ignorecase
set hlsearch
nmap <C-h> :nohlsearch<CR>  " turn off search highlight


" Color scheme
source ~/.local/share/nvim/colors/custom-dark.vim


" Macros
" make links in md-files using URL from "+ buffer
let @u = 'di ["](+)l'
" make quotes in md-files using URL from "+ buffer
let @q = "da[^pa]y%G0o\": \+%"


" Plugins
call plug#begin()

    " Interface improvements
    Plug 'https://github.com/vim-airline/vim-airline'  " Airline
    Plug 'https://github.com/preservim/nerdtree'  " Filetree sidebar
    nmap <C-t> :NERDTreeToggle<CR>
    Plug 'https://github.com/ryanoasis/vim-devicons'  " Icons for filetree
    Plug 'https://github.com/kien/ctrlp.vim'  " Dirs search with <C-P>

call plug#end()
