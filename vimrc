"
" A (not so) minimal vimrc.
"

" Init & Plug
" ==============================

" This goes in front of the plug#begin() func
" It's there to preempt vim-plug for updates or inits
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins Section('~/.vim/plugged')
" ==============================
call plug#begin('~/.vim/plugged')

" Fzf is already installed using ansible, so reference it locally
" Debian based installs will reference this strange directory
""" Tested on Pop_OS & Debian
if !empty(glob('/usr/share/doc/fzf/examples/fzf.vim'))
    " TODO remove once it's confirmed working on both debian & ubuntu/pop
    " echo('local fzf found at /usr/share/ddoc/fzf/examples/fzf.vim')
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    " TODO remove this after confirming it's not necessary here
    " Remember, this gets referenced below in the FZF config section
    " source /usr/share/doc/fzf/examples/fzf.vim
" The fallback should just install the way junegunn recommends
else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
endif

Plug 'scrooloose/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'

" TODO marked for removal because no open issues have been addressed in a year
" Right now markdown messes up folding that toggles during typing in insert
" Plug 'plasticboy/vim-markdown'

Plug 'jamessan/vim-gnupg', { 'branch': 'main' }

Plug 'junegunn/seoul256.vim'

Plug 'NLKNguyen/papercolor-theme'

Plug 'morhetz/gruvbox'

call plug#end()

" General
" ==============================
" You want Vim, not vi.
" When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

filetype plugin on  " Load plugins according to detected filetype.
" filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent              " Indent according to previous line.
set expandtab               " Use spaces instead of tabs.
set softtabstop =4          " Tab key indents by 4 spaces.
set shiftwidth  =4          " >> indents by 4 spaces.
set shiftround              " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                  " Switch between buffers without having to save first.
set laststatus  =2          " Always show statusline.
set display     =lastline   " Show as much as possible of the last line.

set showmode                " Show current mode in command-line.
set showcmd                 " Show already typed keys when more are expected.
set incsearch               " Highlight while searching with / or ?.
set hlsearch                " Keep matches highlighted.

set ttyfast                 " Faster redrawing.
set lazyredraw              " Only redraw when necessary.

set splitbelow              " Open new windows below the current window.
set splitright              " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan                " Searches wrap around end-of-file.
set report      =0          " Always report changed lines.
set synmaxcol   =200        " Only highlight the first 200 columns.

set ignorecase              " Ignore case by default
set smartcase               " Switch to case sensitivity if capitals entered

set number                  " Turn on the line number column

" Cache files for backups/swap/undos need to get created outside working dir
let s:VIMCACHEDIR = $HOME."/.cache/vim"
if exists("*mkdir")
    silent! call mkdir(s:VIMCACHEDIR, "p")
    silent! call mkdir(s:VIMCACHEDIR."/bundle", "p")
    silent! call mkdir(s:VIMCACHEDIR."/swap", "p")
    silent! call mkdir(s:VIMCACHEDIR."/undo", "p")
    silent! call mkdir(s:VIMCACHEDIR."/backup", "p")
else
    echo "Error: cannot create vim cache dirs for swap/undo/backup due to no present mkdir cmd"
    echo "Defaulting to no cache options enabled"
    set noswapfile
    set nobackup
endif

set backupdir=~/.cache/vim/backup// " Custom backup dir to avoid noise in project dirs
set directory=~/.cache/vim/swap// " Same but for swap files
set undodir=~/.cache/vim/undo// " Same but for undo files


" Filetype Behaviors
" ==============================
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
" ==============================
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
" Ensure gopass leaves no traces
" From https://bit.ly/3tl5qYO
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
" Same for macOS
au BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile

" Keymaps
" ==============================

let mapleader = ","

" Disable highlights with leader + h
nnoremap <leader>h :noh<cr>

" fzf
" ==============================
" include the vim fzf function helper if present
if !empty(glob("/usr/share/vim/vimfiles/plugin/fzf.vim"))
    source /usr/share/vim/vimfiles/plugin/fzf.vim
elseif !empty(glob("/usr/share/doc/fzf/examples/fzf.vim"))
    source /usr/share/doc/fzf/examples/fzf.vim
endif

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Rg<cr>

" TODO remove if confirmed that this isnt needed on mac (zsh) & deb/ub/pop linux
" let $FZF_DEFAULT_COMMAND = 'fd . --hidden --exclude .git'


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


" Appearance
" =============================
" Dark/Light mode functions
let s:dark_mode = 0
function! ColorLight()
    " Sets color scheme/appearance settings for a light mode
    " Put light mode color settings here
    " Set colorscheme
    let s:dark_mode = 0
    colorscheme PaperColor
    set background=light
    " Set transparency to terminal application
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText ctermbg=NONE
endfunction
function! ColorDark()
    " Sets color scheme/appearance settings for a light mode
    " Put light mode color settings here
    " Set colorscheme
    let s:dark_mode = 1
    colorscheme gruvbox
    set background=dark
    " Set transparency to terminal application
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText ctermbg=NONE
endfunction
function! ColorToggle()
    " Toggle whether ColorDark() or ColorLight() is called
    if s:dark_mode
        call ColorLight()
    else
        call ColorDark()
    endif
endfunction
" ColorToggle() with leader+d
nnoremap <leader>d :call ColorToggle()<cr>

" Toggle linenumber
nnoremap <leader># :set number!<cr>


" Determine color by time of day and call Color(Dark|Light)
if strftime("%H") < 18 " Light till this hour
    if strftime("%H") < 6
        call ColorDark()
    else
        call ColorLight()
    endif
else " After time of day to change to dark till after midnight
    call ColorDark()
endif

" Set ruler (row/col counter in statusbar)
set ruler


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

