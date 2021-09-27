" Runs the project
nnoremap <leader>r <cmd>GoRun<cr>

" Runs the current file
nnoremap <leader>R <cmd>GoRun %<cr>

" Builds the project
nnoremap <leader>b <cmd>GoBuild<cr>

" Tests the project
nnoremap <leader>tt <cmd>GoTest<cr>

" Tests the function under your cursor
nnoremap <leader>tf <cmd>GoTestFunc<cr>

" Run MetaLinter on the current project
nnoremap <leader>tm <cmd>GoMetaLinter<cr>

" Show go coverage inline WOAH
nnoremap <leader>tc <cmd>GoCoverageToggle<cr>

" Swap to test or back
nnoremap <S-Tab> <cmd>GoAlternate!<cr>
