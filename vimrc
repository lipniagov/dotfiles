" ========================================================================
" Vundle stuff
" ========================================================================

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

" nelstrom's plugin depends on kana's
Plugin 'kana/vim-textobj-user'
" New word for selecting ruby blocks - `r`
Plugin 'nelstrom/vim-textobj-rubyblock'

" Pack of color schemes
Plugin 'flazz/vim-colorschemes'

" Full path fuzzy file, buffer, mru, tag finder
Plugin 'kien/ctrlp.vim'

" Automatic closing of quotes, parenthesis, brackets, etc
Plugin 'Raimondi/delimitMate'

" Code completion
" Plugin 'Valloric/YouCompleteMe'

" Adequate results for (CtrlP + Ag)
Plugin 'FelikZ/ctrlp-py-matcher'

" Toggles between relative and absolute line numbers automatically
Plugin 'jeffkreeftmeijer/vim-numbertoggle.git'

" Enhanced tab behavior based on context
Plugin 'ervandew/supertab'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Run Rspec from VIM
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'

" Status/tab line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Shows a git diff sign column and stages/reverts hunks
Plugin 'airblade/vim-gitgutter'

" Seamless navigation between tmux panes and vim splits
Plugin 'christoomey/vim-tmux-navigator'

" Vim and tmux, sittin' in a tree...
Plugin 'christoomey/vim-tmux-runner'

" Show json in style
Plugin 'elzr/vim-json'

" Dash integration
Plugin 'rizzatti/dash.vim'

" Coffee script
Plugin 'kchmck/vim-coffee-script'

" Reload vim gitgutter on focus (after commit)
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Slim
Plugin 'slim-template/vim-slim.git'

" Markdown preview
Plugin 'shime/vim-livedown.git'

" Post current buffer to gist
Plugin 'mattn/gist-vim'

" Need for gist-vim
Plugin 'mattn/webapi-vim'

" Easy motion
Plugin 'easymotion/vim-easymotion'

" Ember support
Plugin 'dsawardekar/ember.vim'

" Working with mustache and handlebars templates
Plugin 'mustache/vim-mustache-handlebars'

" Elixir integration
Plugin 'elixir-lang/vim-elixir'

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

set relativenumber              " line numbers

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
    set ttymouse=xterm2
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
  set grepprg=ag\ --nogroup\ --nocolor

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
" Vim-RSpec settings
"
let g:rspec_command = "Dispatch bin/rspec {spec}"
let g:rspec_runner = "os_x_iterm2"


" - - - - - - - - - - - - - -
"
" Vim-airline settings
"
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set laststatus=2 "fix vim-airline doesn't appear
"
" - - - - - - - - - - - - - -
"
" Gist-Vim settings
"
let g:gist_post_private = 1
"
" - - - - - - - - - - - - - -
"
" Vim EasyMotion Settings
"
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
"
" - - - - - - - - - - - - - -
"
" YouCompleteMe settings
"
" let g:ycm_dont_warn_on_startup = 0
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1

" let g:ycm_filetype_blacklist = {}

" let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']


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
nnoremap <Leader>f :Ag<Space>

" CtrlP fuzzy searcher
let g:ctrlp_map = '<Leader>t'

" move vertically by visual line
nmap k gk
nmap j gj

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" RSpec.vim mappings
map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>q :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>w :call RunAllSpecs()<CR>

" vim-rails mappings
map <Leader>a :A <CR>
map <Leader>r :R <CR>

" vim-gitgutter mappings
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk

" vim-tmux-runner mappings
nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Requires 'jq' (brew install jq)
function! s:PrettyJSON()
  %!jq .
  set filetype=json
endfunction
command! PrettyJSON :call <sid>PrettyJSON()

" Trigger Dash.VIM
nmap <silent> <leader>d <Plug>DashSearch

" Quickfix list args
" (http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim/5686810#5686810)
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Vim EasyMotion mapping
"
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
"
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"
" ========================================================================

