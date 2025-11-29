" CaldwellDN .vimrc
" Last updated 11/17/2025

" Disable vi compatibility (Issues)
set nocompatible

" Turn syntax highlighting on
syntax on

" Turn numbers for each line on
set number

" Set utf8 as encoding
set encoding=utf8

" Turn on ruler/info at the bottom
set ruler

" Enable filetype detection
filetype on

" Show matching braces when hovering over one
set showmatch

" Use spaces instead of tabs
set expandtab

" Set indentation width
set shiftwidth=4

" Number of spaces a tab counts for
set tabstop=4

" Do not keep backup files
set nobackup

" No wrapping
set nowrap

" Enable monokai colors
syntax enable
colorscheme monokai

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
set list
