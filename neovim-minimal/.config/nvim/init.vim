syntax enable
set number
set encoding=utf-8
set cursorline
set colorcolumn=80
colorscheme black-pastel
set termguicolors

" Enable autowrite (automatically write when :make or :GoBuild are called)
set autowrite

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Don't litter swp files everywhere
set nobackup
set nowritebackup

" Unbreak vim's regex implementation
set magic

" Allow hidden buffers to be opened without a bang.
set hidden

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set spellcheck language
set spelllang=en

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
set notimeout ttimeout ttimeoutlen=50

" Live substitution
set inccommand=nosplit

" Indentation settings for using hard tabs for indent.
set softtabstop=2
set shiftwidth=2
set tabstop=2
set noexpandtab

" Auto indent differently per file
autocmd FileType c setlocal noet ts=8 sw=8 tw=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80
autocmd FileType cpp setlocal noet ts=8 sw=8 tw=80
autocmd FileType s setlocal noet ts=8 sw=8
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType hy setlocal filetype=lisp
autocmd FileType sh setlocal noet ts=4 sw=4
autocmd BufRead,BufNewFile *.js setlocal et ts=2 sw=2
autocmd FileType html setlocal et ts=2 sw=2
autocmd FileType htmldjango setlocal et ts=2 sw=2
autocmd FileType ruby setlocal et ts=2 sw=2
autocmd FileType scss setlocal et ts=2 sw=2
autocmd FileType css setlocal et ts=2 sw=2
autocmd FileType yaml setlocal et ts=2 sw=2
autocmd FileType toml setlocal et ts=2 sw=2
autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
autocmd FileType text setlocal tw=80
autocmd FileType meson setlocal noet ts=2 sw=2
autocmd FileType bzl setlocal et ts=2 sw=2
autocmd FileType typescript setlocal et ts=2 sw=2
autocmd FileType python setlocal et ts=4 sw=4
autocmd BufNewFile,BufRead *.ms set syntax=python ts=4 sw=4 noet
autocmd FileType tex hi Error ctermbg=NONE
autocmd FileType mail setlocal noautoindent
autocmd FileType gmi set wrap linebreak

" Multiline indenting
set breakindent

" FZF for file switching
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
nmap <leader><leader> :Files<CR>

" Traverse back with arrows
set whichwrap=b,s,<,>,[,]

" Highlight searches
" \s to temp hide the search results
nmap <leader>n :noh<CR>

" Run tabular with \t
nmap <leader>T :Tabularize /

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

" response time
set updatetime=100

" Switch focus to undotree on toggle
let g:undotree_SetFocusWhenToggle = 1

" Enable battery statusline
let g:airline_section_y = '%{battery#component()}'
let g:battery#component_format = "%s %v%"

" Use lines for gitgutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'
