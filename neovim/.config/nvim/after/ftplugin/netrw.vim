" remove annoying 'do you wish to save?' popup
autocmd FileType netrw setl bufhidden=delete

" move about
nmap <buffer> l <CR>
nmap <buffer> h -

" create and delete
nmap <buffer> nf %
nmap <buffer> nd d
nmap <buffer> x D

" select, move, and copy
nmap <buffer> <Space> mf
nmap <buffer> p mc
nmap <buffer> v mm

" bulk rename with something like vidir
" nmap <buffer> r :Renamer .

" defualt to not showing hidden files
" gh to toggle on/off
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
