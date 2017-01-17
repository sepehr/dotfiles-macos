"Plugins
call plug#begin('~/.vim/bundle')
    Plug 'tpope/vim-sensible'
call plug#end()

"Appearance
syntax enable

if filereadable(expand('~/.vimrc_background'))
  let base16colorspace=256
  source ~/.vimrc_background
endif

highlight clear LineNr
highlight clear SignColumn
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
set tabstop=4

"Mappings
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohlsearch<cr>
nmap <D-1> :NERDTreeToggle<cr>

"Auto Commands
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"Search
set hlsearch
set incsearch

"Splits
set splitbelow
set splitright

