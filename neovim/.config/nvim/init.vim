syntax enable
set relativenumber
set encoding=utf-8
set cursorline
set colorcolumn=80
set termguicolors
set background=dark
colorscheme black-pastel
let g:airline_theme='base16'

" Coc Extensions
let g:coc_global_extensions = ['coc-rust-analyzer', 'coc-clangd', 'coc-vimlsp', 'coc-tsserver', 'coc-snippets', 'coc-sh', 'coc-python', 'coc-json', 'coc-java', 'coc-html', 'coc-godot', 'coc-css', 'coc-lua']

" Enable autowrite (automatically write when :make or :GoBuild are called)
set autowrite

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Don't litter swp files everywhere
set nobackup
set nowritebackup

" Enable nvim diffing
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

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
set scrolloff=8

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=50

" Live substitution
set inccommand=nosplit

" Indentation settings for using hard tabs for indent.
set softtabstop=2
set shiftwidth=2
set tabstop=2
set noexpandtab

" Open all folds by default
set foldlevelstart=99

" Auto indent differently per file
autocmd FileType c setlocal noet ts=8 sw=8 tw=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80
autocmd FileType cpp setlocal noet ts=8 sw=8 tw=80
autocmd FileType s setlocal noet ts=8 sw=8
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType hy setlocal filetype=lisp
autocmd FileType sh setlocal et ts=2 sw=2
autocmd FileType js setlocal et ts=2 sw=2
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
autocmd FileType lua setlocal noet ts=4 sw=4
autocmd FileType python setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.ms set syntax=python ts=4 sw=4 noet
autocmd FileType tex hi Error ctermbg=NONE
autocmd FileType mail setlocal noautoindent
autocmd FileType gmi set wrap linebreak
autocmd FileType wiki setlocal tw=80 et ts=2 sw=2

" Multiline indenting
set breakindent

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Pandoc the current file
nmap <leader>m :w<CR>:!pandoc % -o %:t:r.pdf<CR>
nmap <leader>M :!zathura %:t:r.pdf &<CR>

" FZF for file switching
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_preview_window = []
nnoremap <leader><leader> :Files<CR>
nnoremap <leader>[ :CtrlSF 
nnoremap <leader>] :GFiles<CR>
nnoremap <leader>/ :Buffers<CR>
nnoremap <leader><CR> :FloatermNew! --height=0.9 --width=0.8 --autoclose=2<CR>

" wiki.vim
let g:wiki_root = '~/docs/memex'
" override <leader>ww for wiki.vim
nmap <leader>ww <plug>(wiki-index)\|:cd ~/docs/memex<cr>
" override <leader><leader> for wiki.vim
autocmd FileType wiki nnoremap <leader><leader> :WikiFzfPages<CR>

" terminal
hi FloatermBorder guibg=black guifg=grey
let g:floaterm_keymap_kill = '<leader><Esc>'

" hexokinase.vim
let g:Hexokinase_highlighters = ['backgroundfull']

" dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Traverse back with arrows
set whichwrap=b,s,<,>,[,]

" Highlight searches
" \s to temp hide the search results
nnoremap <leader>n :noh<CR>

" Run tabular with \t
nnoremap <leader>T :Tabularize /

" Set f5 and \u as hotkeys to show Undo Tree
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" Set f3 as hotkey to show Hidden characters
nnoremap <F3> :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Set spell toggle
nnoremap <leader>s :set spell!<CR>

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

" Remap j and k to move by display with wrapped lines, but also move the
" correct number of lines when preceded with a count. Counts greater than 5
" will be added to the movement history to make Control-O and Control-I work.
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" vim-go is used instead of coc-nvim, but there's a few settings to change to
" make it a more seamless transition
let g:go_doc_popup_window = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>1, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>1, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>1, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>1, 'tabe')

" vim-visual-multi
let g:VM_leader = "\,"
