let g:ale_disable_lsp = 1

call plug#begin('~/.vim/bundle')

" source plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ledger/vim-ledger'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'rareitems/printer.nvim'
" Order of these JS plugins matters
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" Should always be last plugin
Plug 'ryanoasis/vim-devicons'

call plug#end()             " required
filetype plugin indent on   " required

" apply colorscheme
set termguicolors
colorscheme jellybeans
let g:jellybeans_overrides = {
\    'background': { 'guibg': '0d0d11' },
\}

" enable airline theme and populate powerline fonts
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

" vim-markdown stuff
let g:vim_markdown_folding_disabled = 1

" ignore node modules
let g:ctrlp_custom_ignore = '\vnode_modules'

" misc settings
syntax on
set number
set showcmd
set encoding=UTF-8
set signcolumn=yes
set cursorline
set colorcolumn=78
set clipboard+=unnamedplus
set exrc

" a plugin
source ~/.vim/plugin/matchit.vim
filetype plugin on

" more regular expressions when searching
nnoremap / /\v
vnoremap / /\v

" set tab size
set tabstop=2
set shiftwidth=2
set expandtab

" jj as escape
inoremap jj <esc>

" Ctrl + direction to move between panes
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" Ctrl-A to move to start of line in insert mode
inoremap <c-a> <c-o>^
" Ctrl-E to move to end of line in insert mode
inoremap <c-e> <c-o>$

" <space> as leader
let mapleader=' '

" <leader>y/p/P Copy/Paste/PasteBefore from global buffer
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" <leader>q to close current pane
nnoremap <leader>q :q<CR>

""" coc.nvim stuff
set hidden
set shortmess+=c

" Limit autocomplete items to 8
set pumheight=8 

" Indent stuff
highlight IndentBlanklineChar guifg=#232323

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Jump to definition
nmap <silent> gd <Plug>(coc-definition)
" Show usages of symbol
nmap <silent> gr <Plug>(coc-references)
" Rename a symbol
nmap <leader>rn <Plug>(coc-rename)
" Autofix current line
nmap <leader>f <Plug>(coc-fix-current)
" Open the fix-actions menu
nmap <leader>a <Plug>(coc-codeaction)

" K shows docs in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Hover over a symbol to show it's type at bottom of window
autocmd CursorHold * silent call CocActionAsync('highlight')

" ale stuff
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚑'

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <leader>l :lopen<CR>
nmap <leader>ll :lclose<CR>

" ale - Close location list on buffer close:
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END


" Nerdtree stuff
" Leader-n to toggle nerdtree pane
nnoremap <leader>n :NERDTree<CR>
