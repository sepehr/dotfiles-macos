syntax enable 

"// Vundle plugin manager"
so ~/.vundle.vim

"// Appearance"
colorscheme atom-dark
set t_Co=256
set guifont=Hasklig:h15

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"// ?"
set backspace=indent,eol,start
let mapleader=','
set number
set linespace=15

"// Mappings"
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohlsearch<cr>
nmap <D-1> :NERDTreeToggle<cr>

"// Auto Commands"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"// Search"
set hlsearch
set incsearch

"// Splits"
set splitbelow
set splitright

