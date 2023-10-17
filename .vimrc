" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 4 spaces
set shiftwidth=2     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
set autochdir
:au FocusLost * :wa
" execute pathogen#infect()
set nowritebackup
set nobackup
set noswapfile
set autowrite
:highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/
" incremental search
set incsearch
" highlight search
set hlsearch
set ignorecase
set smartcase
set clipboard=unnamedplus
set ruler

" set colors
set background=dark
hi SpecialKey guifg=Blue
hi MoreMsg guifg=Green
hi Visual guifg=NONE guibg=NONE
hi Folded ctermbg=4 guibg=Blue
hi FoldColumn ctermbg=7
hi DiffAdd guibg=Blue
hi DiffChange guibg=Magenta
hi DiffDelete guibg=Cyan
hi Normal guifg=Gray guibg=Black
hi Cursor guibg=White
hi lCursor guibg=White
hi Comment guifg=Cyan
hi Constant guifg=Magenta
hi Special guifg=Red
hi Identifier guifg=Cyan
hi Statement guifg=Yellow
hi PreProc guifg=Blue
hi Type guifg=Green
hi Underlined guifg=Blue
hi Todo guifg=Black
