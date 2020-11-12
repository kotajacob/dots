" =============
"  Kota VIMrc 
" =============
"
" =================
"    Use Vundle
" =================
" Make vim the same on any os
set nocompatible

" Needed for Vundle
filetype off 

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" big fat autocompletion engine
Plugin 'Shougo/deoplete.nvim'

" fancy source code search tool
Plugin 'mileszs/ack.vim'

" fancy bar at the bottom
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Syntax Checking
Plugin 'vim-syntastic/syntastic'

" Use git from inside vim :D
Plugin 'tpope/vim-fugitive'

" Good go language support
Plugin 'fatih/vim-go'

" Easy quoting and tagging
Plugin 'tpope/vim-surround'

" Auto complete close brackets
Plugin 'spf13/vim-autoclose'

" Use tabular to align things easily
Plugin 'godlygeek/tabular'

" Good commenting plugin
Plugin 'tpope/vim-commentary'

" FZF quick file switching
Plugin 'junegunn/fzf.vim'

" Visual undo tree with :MundoToggle
Plugin 'mbbill/undotree'

" Use git gutter for a nice display
Plugin 'airblade/vim-gitgutter'

" Make <C-a> and <C-x> work with dates
Plugin 'tpope/vim-speeddating'

" Fix * search when in visual mode :D
Plugin 'nelstrom/vim-visual-star-search'

" Vim tmux navigate
Plugin 'christoomey/vim-tmux-navigator'

" Black Pastel Theme
Plugin 'https://git.sr.ht/~kota/black-pastel'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Manual System Plugins
set rtp+=/usr/share/vim/vimfiles


" ================
" Graphical Tweaks
" ================

syntax enable
set number
set ruler
set encoding=utf-8
set cursorline
set colorcolumn=80
set background=dark
colorscheme black-pastel
let g:airline_theme='base16'
set termguicolors

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'

" ===========
" General Use
" ===========

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Don't litter swp files everywhere
set backupdir=~/.cache
set directory=~/.cache

" Unbreak vim's regex implementation
set magic 

" Allow hidden buffers to be opened without a bang.
set hidden
 
" Good command line completion.
set wildmenu
 
" Show partial commands in the last line of the screen.
set showcmd
 
" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action.
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
set nostartofline
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set spellcheck language
set spelllang=en
 
" Use visual bell instead of beeping when doing something wrong
" And reset the terminal code for the visual bell.
set visualbell
set t_vb=

" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2
 
" Set word wrapping on
set wrap
set linebreak

" Set when vim will scroll
set scrolloff=6
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200


" ==========
" Formatting
" ==========
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
set softtabstop=8
set shiftwidth=8
set tabstop=8
set noexpandtab

" Auto indent differently per file
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Multiline indenting
set breakindent


" ========
" Bindings
" ========

" FZF for file switching
nmap <leader><leader> :FZF<CR>

" Vim stock explorer for file switching
nmap <leader>e :Explore<CR>

" Run go
" nmap <leader>g :!go run %<CR>

" Traverse back with arrows
set whichwrap=b,s,<,>,[,]

" Highlight searches
" \s to temp hide the search results
nmap <leader>n :noh<CR>
set hlsearch

" Run tabular with \t
nmap <leader>t :Tabularize /

" Pandoc the current file
nmap <leader>m :w<CR>:!pandoc % -o %:t:r.pdf<CR>
nmap <leader>M :!zathura %:t:r.pdf &<CR>

" Set f5 and \u as hotkeys to show Undo Tree
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" Set f3 as hotkey to show Hidden characters
nnoremap <F3> :set list!<CR> 
nmap <leader>h :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Set spell toggle
nmap <leader>s :set spell!<CR>

" Map %% to return my current working directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>


" ====================
" Misc Plugin Settings
" ====================

" Git symbol response time
set updatetime=100
