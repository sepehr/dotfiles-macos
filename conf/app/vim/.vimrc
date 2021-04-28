""Plugins
call plug#begin('~/.vim/bundle')
    Plug 'posva/vim-vue'
    Plug 'tpope/vim-sensible'
    Plug 'scrooloose/nerdtree'
    Plug 'itchyny/lightline.vim'
    Plug 'whiteinge/diffconflicts'
    Plug 'arcticicestudio/nord-vim'
call plug#end()

""Appearance
syntax enable

"" NERDTree Configs
map <C-1> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Base16 scheme
"See: chriskempson/base16-vim
"if filereadable(expand('~/.vimrc_background'))
"    let base16colorspace=256
"    source ~/.vimrc_background
"endif

highlight clear LineNr
highlight clear SignColumn
set cursorline
set t_Co=256
set guifont=Hasklig:h15

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set backspace=indent,eol,start
let mapleader=','
set number
set linespace=15
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

""Mappings
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohlsearch<cr>
nmap <D-1> :NERDTreeToggle<cr>
set pastetoggle=<F3>

""Auto Commands
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

""Search
set hlsearch
set incsearch

""Splits
set splitbelow
set splitright

""Misc
set encoding=utf-8
set clipboard=unnamed
set whichwrap+=<,>,h,l,[,]

