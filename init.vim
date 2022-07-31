set encoding=utf-8  " File encoding for writing
set fileencodings=utf-8,cp1251,utf-16le  " File encodings for reading


" Interface settings
set number
set scrolloff=7
set mouse=a
set splitright
set splitbelow


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


" Color scheme
source ~/.local/share/nvim/colors/custom-dark.vim

" ------------------------------------------------------------------------------
"                                Mappings 
" ------------------------------------------------------------------------------

" Keyboard settings
" Назначаем русские буквы соотв. кнопкам английской раскладки
set keymap=russian-jcukenwin
set iminsert=0 " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0 " Чтобы при старте поиск был на английском, а не русском (start > /)

" Кастомный hotkey для переключения раскладок
inoremap <C-l> <C-^>
" Turn off search result highlight
nmap <C-h> :nohlsearch<CR>  " turn off search highlight
" Replace spaces with underscores in visual block
xnoremap m_ :s/\%V /_/g<CR> :nohlsearch<CR> g``
" Replace spaces with hyphens in visual block
xnoremap m- :s/\%V /-/g<CR> :nohlsearch<CR> g``
" Make a markdown quote using clipboard content
xnoremap mq d :call MakeMdQuote()<CR>

" ------------------------------------------------------------------------------
"                                Commands
" ------------------------------------------------------------------------------

let configs_dir_path = "~/.config/nvim/"
let commands_config = expand(configs_dir_path . "commands.vim")

" Call on commands from an external file
if filereadable(commands_config)
  exec "source " . commands_config
endif

" ------------------------------------------------------------------------------
"                                Functions 
" ------------------------------------------------------------------------------

let functions_config = expand(configs_dir_path . "functions.vim")

" Call on functions from an external file
if filereadable(functions_config)
  exec "source " . functions_config
endif


" ------------------------------------------------------------------------------
"                                  Macros
" ------------------------------------------------------------------------------

let macros_config = expand(configs_dir_path . "macros.vim")

" Call on macros from an external file
if filereadable(macros_config)
  exec "source " . macros_config
endif



" Plugins
call plug#begin()

    " Manually installed plugins
    Plug 'https://github.com/vim-scripts/restore_view.vim'  " Save and restore Vim views automatically
    set viewoptions=cursor,folds,slash,unix

    " Interface improvements
    Plug 'https://github.com/vim-airline/vim-airline'  " Airline
    Plug 'https://github.com/preservim/nerdtree'  " Filetree sidebar
    nmap <C-t> :NERDTreeToggle<CR>
    Plug 'https://github.com/ryanoasis/vim-devicons'  " Icons for filetree
    Plug 'https://github.com/kien/ctrlp.vim'  " Dirs search with <C-P>
    Plug 'https://github.com/mileszs/ack.vim'  " Recursively search for a pattern inside files
    let g:ackprg = 'ag --vimgrep'

    " Text editing improvements
    Plug 'https://github.com/jiangmiao/auto-pairs'  " Autocomplete symbols pairs (e.g. brackets)
    Plug 'https://github.com/tpope/vim-surround'  " surround lines with patterns
    let b:surround_{char2nr('i')} = "_\r_"
    let b:surround_{char2nr('b')} = "**\r**"
    let b:surround_{char2nr('c')} = "```\r```"
    Plug 'https://github.com/mattn/emmet-vim'  " Fast HTML blocks insertions with Emmet plugin

    " IDE features
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

    " Git integration
    Plug 'https://github.com/airblade/vim-gitgutter'  " Show changes since the last commit in a side column
    Plug 'https://github.com/tpope/vim-fugitive'  " Use git commands from Vim cmd

call plug#end()


" LSP settings for IDE features

lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -- nvim key mapping
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(), -- turn on/off autocompletion
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF




lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF



" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>


map gn :bn<cr>
map gp :bp<cr>
map gw :Bclose<cr>

set colorcolumn=79

" run current script with python3 by CTRL+R in command and insert mode
"autocmd FileType python map <buffer> <C-r> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"autocmd FileType python imap <buffer> <C-r> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
