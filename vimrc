" ========================================================================
" Vundle stuff
" ========================================================================
language en_US
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" - - - - - - - - - - - - - - -
" My bundles

" File/folder project tree
Plugin 'scrooloose/nerdtree'

" Tools for rails dev
Plugin 'tpope/vim-rails'

" Tools for ruby dev
Plugin 'vim-ruby/vim-ruby'

" Wisely add 'end' in ruby
Plugin 'tpope/vim-endwise'

" Automatically save changes to disk
Plugin 'vim-auto-save'

" Vim plugin for the_silver_searcher, 'ag'
Plugin 'rking/ag.vim'

" Comment lines with gcc, gc + target of motion
Plugin 'tpope/vim-commentary'

" Pack of color schemes
Plugin 'flazz/vim-colorschemes'

" Full path fuzzy file, buffer, mru, tag finder
Plugin 'kien/ctrlp.vim'

" Automatic closing of quotes, parenthesis, brackets, etc
Plugin 'Raimondi/delimitMate'

" Adequate results for (CtrlP + Ag)
Plugin 'FelikZ/ctrlp-py-matcher'

" Enhanced tab behavior based on context
Plugin 'ervandew/supertab'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Status/tab line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Shows a git diff sign column and stages/reverts hunks
Plugin 'airblade/vim-gitgutter'

" Reload vim gitgutter on focus (after commit)
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Support command mode in Russian keyboard layout
Plugin 'powerman/vim-plugin-ruscmd.git'

" - - - - - - - - - - - - - - -
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set color scheme
colorscheme monokai

" ========================================================================
" Common
" ========================================================================

set nobackup                    " get rid of annoying ~file
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=500                 " keep 500 lines of command line history
set ruler                       " show the cursor position all the time
set autoindent                  " auto indenting
set showcmd                     " display incomplete commands
set wildmenu

set number                      " line numbers

" searching
set hlsearch     " Highlight all matches after entering pattern
set ignorecase   " ignore case in search
set smartcase    " until search pattern have at least one capital letter

" Don't wait so long for the next keypress
set timeoutlen=500

" Use Silver Searcher instead of grep
set grepprg=ag

" Ignore stuff that can't be opened
set wildignore+=tmp/**

" Don't clutter my dirs up with swp and tmp files
set backupdir=~/.tmp
set directory=~/.tmp

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" ========================================================================
" Editor && Ruby
" ========================================================================

syntax on                 " Enable syntax highlighting
set clipboard=unnamed     " Work with system clipboard

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,coffee setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml,coffee setlocal path+=lib
  autocmd FileType ruby,eruby,yaml,coffee setlocal colorcolumn=80,120
  " highlight ColorColumn ctermbg=235 guibg=#2c2d27

  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

runtime macros/matchit.vim "Use built-in matchit plugin ( use % on (,{,[... )

" Remove trailing whitespace on save for ruby files.
au BufWritePre *.rb :%s/\s\+$//e

" Display extra whitespace
set list listchars=tab:»·,trail:·

" causes Vim to move the cursor to the previous matching bracket for half a second
set showmatch

set smarttab
set shiftround
set sw=2

set mouse=a
if has("mouse_sgr")
    set ttymouse=sgr
else
  if !has('nvim')
    set ttymouse=xterm2
  endif
end

" ========================================================================
" Plugin-specific settings
" ========================================================================
"
" - - - - - - - - - - - - - -
"
" NERDtree settings
"
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeChDirMode=2

" close window if only nerdTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files
let NERDTreeShowHidden=1

" - - - - - - - - - - - - - -
"
" vim-auto-save settings
"
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" - - - - - - - - - - - - - -
"
" CtrlP settings
"
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore node_modules
    \ --ignore bower_components
    \ --ignore tmp
    \ -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use external matcher for adequate results
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" - - - - - - - - - - - - - -
"
" Supertab settings
"
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

" - - - - - - - - - - - - - -
"
" Vim-airline settings
"
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set laststatus=2 "fix vim-airline doesn't appear
"
" ========================================================================
" Mappings
" ========================================================================

let mapleader = ","

:imap jk <Esc>

" Disable K looking stuff up
map K <Nop>

" Disable Ex mode
map Q <Nop>

" Clear search highlighting
map <leader>h :nohlsearch<cr>

" Search results(grep) - next and prev
autocmd VimEnter * map <C-n> :cn<CR>
autocmd VimEnter * map <C-p> :cp<CR>

" NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

" Trigger Ag
nnoremap <Leader>f :Ag --hidden<Space>

" CtrlP fuzzy searcher
let g:ctrlp_map = '<Leader>t'

" move vertically by visual line
nmap k gk
nmap j gj

" move between splits
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" vim-rails mappings
map <Leader>a :A <CR>
map <Leader>r :R <CR>

" vim-gitgutter mappings
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
