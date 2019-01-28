"
" A (not so) minimal vimrc.
"

" Init & Plug
" ==============================================================================

" This goes in front of the plug#begin() func
" It's there to preempt vim-plug for updates or inits
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins Sectionn('~/.vim/plugged')
" ==============================================================================
call plug#begin('~/.vim/plugged')

" Fzf is already installed using ansible, so reference it locally
Plug '~/.local/share/fzf'
Plug 'junegunn/fzf.vim'

Plug 'junegunn/seoul256.vim'

Plug 'NLKNguyen/papercolor-theme'

Plug 'scrooloose/nerdcommenter'

call plug#end()


" General
" ==============================================================================

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

filetype plugin on  " Load plugins according to detected filetype.
" filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

"set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

" Filetype general sets
au FileType javascript setlocal tabstop=2 shiftwidth=2
au FileType javascript.jsx setlocal tabstop=2 shiftwidth=2
au FileType typescript setlocal tabstop=2 shiftwidth=2
au FileType yaml setlocal tabstop=2 shiftwidth=2
au FileType yml setlocal tabstop=2 shiftwidth=2
au FileType html setlocal tabstop=2 shiftwidth=2
au FileType xml setlocal tabstop=2 shiftwidth=2
" Go specific ( might not be needed as go uses 4:4 format )
au FileType go set softtabstop=4


" NERDCommenter
" ----------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multiline comments
let g:NERDCompactSexyComs = 1
" Align linewise comment delimiters flush left instead of following indents
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful for commenting regions)
let g:NERDCommentEmptyLines = 1
" Trim trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" From https://bit.ly/2kp8npv
" Used to recognize & handle jsx comments
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' } }

" Keymaps
" ==============================================================================

let mapleader = ","

" Disable highlights with leader + h
nnoremap <leader>h :noh<cr>

" fzf {{{
"================================
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Rg<cr>
" }}}


set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Set colorscheme
colorscheme PaperColor

" Autoreload vimrc on changes
" from: http://bit.ly/2CfyFTu
" For improved reliability, only uncomment when in vimrc edit session
" augroup myvimrchooks
"     au!
"     autocmd bufwritepost ~/dotfiles/vim/vimrc source ~/.vimrc
" augroup END

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
"set backup
"set backupdir   =$HOME/.vim/files/backup/
"set backupext   =-vimbackup
"set backupskip  =
"set directory   =$HOME/.vim/files/swap//
"set updatecount =100
"set undofile
"set undodir     =$HOME/.vim/files/undo/
"set viminfo     ='100,n$HOME/.vim/files/info/viminfo

