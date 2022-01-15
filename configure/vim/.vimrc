set number
syntax on
set textwidth=120
set showmatch

" set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set undolevels=1000
set tabstop=4

set showcmd
set showmode

" set cursorline
" set cursorcolumn

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


call plug#begin()
Plug 'preservim/NERDTree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'OmniSharp/omnisharp-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set t_Co=256
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1

let g:OmniSharp_server_stdio = 1
let g:coc_global_extensions= [ 'coc-omnisharp' ]
