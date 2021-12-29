" Use vim-plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'https://git.sr.ht/~kota/black-pastel'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/gv.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'stsewd/gx-extended.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'machakann/vim-highlightedyank'
Plug 'voldikss/vim-floaterm'
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'
Plug 'habamax/vim-godot'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'quick-lint/quick-lint-js', {'rtp': 'plugin/vim/quick-lint-js.vim', 'tag': '1.0.0'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ggandor/lightspeed.nvim'
call plug#end()

" Make vim pretty
set encoding=utf-8
set relativenumber
set cursorline
set colorcolumn=80
set termguicolors
set background=dark
colorscheme black-pastel

" Disable mode printing since it's in the status bar
set noshowmode

" Enable autowrite (automatically write when :make or :GoBuild are called)
set autowrite

" Set the default register to * so I can have a shared OS clipboard.
set clipboard=unnamed

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Don't litter swp files everywhere
set nobackup
set nowritebackup

" always use signcolumn
set signcolumn=yes

" Enable nvim diffing
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

" Unbreak vim's regex implementation
set magic

" response time
set updatetime=100

" Allow hidden buffers to be opened without a bang.
set hidden

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
set nostartofline

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

" Multiline indenting
set breakindent

" Scroll one line at a time with ALT-J or ALT-K
map <A-j> <C-E>
map <A-k> <C-Y>

" Move between splits without C-W prefix
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Telescope + nnn
lua << EOF
require('telescope').setup{}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
nnoremap - <cmd>Telescope file_browser<CR>
nnoremap <leader><leader> <cmd>Telescope find_files<cr>
nnoremap <leader>[ <cmd>Telescope live_grep<cr>
nnoremap <leader>] <cmd>Telescope git_files<cr>
nnoremap <leader>/ <cmd>Telescope buffers<cr>
nnoremap z= <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap <space>ca <cmd>Telescope lsp_code_actions<cr>
nnoremap <space>el <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <space><space> <cmd>Telescope lsp_document_symbols<cr>

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

" wiki.vim
let g:wiki_root = '~/docs/memex'
" override <leader>ww for wiki.vim
nmap <leader>ww <plug>(wiki-index)\|:cd ~/docs/memex<cr>

" hexokinase
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

" floaterm can open non floating terminals nicely too
hi FloatermBorder guibg=black guifg=grey
let g:floaterm_keymap_kill = '<leader><Esc>'
nnoremap <leader><CR> :FloatermNew! --autoclose=2 --wintype=vsplit<CR>

" hexokinase.vim
let g:Hexokinase_highlighters = ['backgroundfull']

" Traverse back with arrows
set whichwrap=b,s,<,>,[,]

" Highlight searches
" \n to temp hide the search results
nnoremap <leader>n :noh<CR>

" show extra whitespace
match Error /\s\+$/
autocmd BufWinEnter * match Error /\s\+$/
autocmd InsertEnter * match Error /\s\+\%#\@<!$/
autocmd InsertLeave * match Error /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Set f3 as hotkey to show Hidden characters
nnoremap <F3> :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Set spell toggle
nnoremap <leader>s :set spell!<CR>

" Map %% to return my current working directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Use lines for gitgutter
let g:gitgutter_sign_priority=9
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

" Create a Date command... mostly for hugo.
command Date :exec 'normal a'.substitute(system("date -Iseconds"),"[\n]*$","","")

" vim-visual-multi
let g:VM_leader = "<space>,"

lua << EOF
-- Lightspeed config
require'lightspeed'.setup {
  exit_after_idle_msecs = { labeled = 4500, unlabeled = 4000 },
}

-- nvim-lspconfig
local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>s', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'gopls', 'gdscript', 'cssls', 'html', 'jsonls', 'quick_lint_js', 'vimls', 'zls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- null-ls (use non-language server tools like language servers)
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({extra_args = { "--use-tabs", "--no-semi" }}),
    },
    on_attach = on_attach,
})

-- Make the diagnostic messages look a little better
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- disable virtual text
    virtual_text = false,

    -- show signs
    signs = true,

    -- delay update diagnostics
    update_in_insert = false,
    -- display_diagnostic_autocmds = { "InsertLeave" },
  }
)
EOF

" Auto indent differently per file
autocmd FileType c setlocal noet ts=4 sw=4 tw=80
autocmd FileType h setlocal noet ts=4 sw=4 tw=80
autocmd FileType cpp setlocal noet ts=4 sw=4 tw=80
autocmd FileType go setlocal noet ts=4 sw=4 tw=80
autocmd FileType hy setlocal filetype=lisp
autocmd FileType sh setlocal et ts=2 sw=2
autocmd FileType html setlocal et ts=2 sw=2
autocmd FileType ruby setlocal et ts=2 sw=2
autocmd FileType scss setlocal et ts=2 sw=2
autocmd FileType css setlocal et ts=2 sw=2
autocmd FileType yaml setlocal et ts=2 sw=2
autocmd FileType toml setlocal et ts=2 sw=2
autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
autocmd FileType text setlocal tw=80
autocmd FileType meson setlocal noet ts=2 sw=2
autocmd FileType bzl setlocal et ts=2 sw=2
autocmd FileType javascript setlocal noet ts=4 sw=4 tw=80
autocmd FileType typescript setlocal noet ts=4 sw=4 ts=80
autocmd FileType lua setlocal noet ts=4 sw=4 tw=80
autocmd FileType python setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.ms set syntax=python ts=4 sw=4 noet
autocmd FileType tex hi Error ctermbg=NONE
autocmd FileType mail setlocal noautoindent
autocmd FileType gmi set wrap linebreak
autocmd FileType wiki setlocal tw=80 et ts=2 sw=2

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

" based on henry's statusline
" https://git.sr.ht/~hnaguski/pineapple-dots/tree/master/item/neovim/.config/nvim/init.vim
" set highlights for statusline based on mode, uses gui* so make sure you can
" use termguicolors. This funcion also returns the current mode as a word
function StatusColor() abort
	let l:mode = mode()
	if l:mode ==# 'n'
		highlight modeHL guibg='#7cafc2' guifg='#000000'
		let l:mode = "normal"
	elseif l:mode ==# 'i'
		highlight modeHL guibg='#a1b56c' guifg='#000000'
		let l:mode = "insert"
	elseif l:mode ==# 'v'
		highlight modeHL guibg='#ba8baf' guifg='#000000'
		let l:mode = "visual"
	elseif l:mode ==# 'V'
		highlight modeHL guibg='#ba8baf' guifg='#000000'
		let l:mode = "visual line"
	elseif l:mode ==# "\<C-V>"
		highlight modeHL guibg='#ba8baf' guifg='#000000'
		let l:mode = "visual block"
	elseif l:mode ==# 'R'
		highlight modeHL guibg='#f7ca88' guifg='#000000'
		let l:mode = "replace"
	elseif l:mode ==# 'c'
		highlight modeHL guibg='#dc9656' guifg='#000000'
		let l:mode = "command"
	endif
	return l:mode
endfunction

" style filename based on it's status
function Filestatus() abort
	if &modified
		highlight fileHL gui=italic
	elseif &readonly
		highlight fileHL gui=NONE guifg='#e65737'
	elseif &modified && &readonly
		highlight fileHL gui=italic guifg='#e65737'
	else
		highlight clear fileHL
	endif
	return "%#fileHL# %F"
endfunction

" get warning/error messages from lsp
function LspWarnings()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:warnings = luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
		let l:warnings .= l:warnings == 1 ? " warning" : " warnings"

		if l:warnings >= 1
			return printf('%%#Warning# %s ', warnings)
		else
			return printf('')
		endif
	else
		return ""
	endif
endfunction

function LspErrors()
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
		let l:errors = luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
		let l:errors .= l:errors == 1 ? " error" : " errors"

		if l:errors >= 1
			return printf('%%#Error# %s ', errors)
		else
			return printf('')
		endif
	else
		return ""
	endif
endfunction

function WordCount()
	if index(g:WCfiletypes, &filetype) != -1
		return printf(' words %d ', wordcount().words)
	else
		return ""
	endif
endfunction
function LineCount()
	return printf(' ㏑ %d/%d ', line('.'), line('$'))
endfunction

" default statusline highlight
highlight statusdefault guibg='#000000' guifg='#dedcdc'

" clear statusline
let &statusline = ''
" show mode colorfully
let &statusline .= "%#modeHL# %{StatusColor()} "

" file name with modified + readonly status
let &statusline .= "%{%Filestatus()%}%#statusdefault#"

" right side
let &statusline .= "%="

" show word count in some files
let WCfiletypes = [ 'text', 'wiki', 'markdown' ]
let &statusline .= "%{WordCount()}"
" filetype with different color for some reason (it looks nice)
let &statusline .= '%{%(empty(&filetype) ? "" : "%#colorcolum# ".&filetype)%} '
" color based on mode
let &statusline .= "%#modeHL#"
let &statusline .= "%{LineCount()}"
" lsp warnings/errors
let &statusline .= "%{%LspWarnings()%}"
let &statusline .= "%{%LspErrors()%}"
