vim.cmd( "autocmd FileType netrw nmap <buffer> <C-l> :wincmd l<CR>" )
vim.cmd( "autocmd FileType netrw nmap <buffer> <C-h> :wincmd h<CR>" )
vim.cmd( "autocmd FileType netrw nmap <buffer> <C-k> :wincmd k<CR>" )
vim.cmd( "autocmd FileType netrw nmap <buffer> <C-j> :wincmd j<CR>" )

vim.cmd( "autocmd FileType netrw nmap <buffer> h <Plug>NetrwBrowseUpDir" )
vim.cmd( "autocmd FileType netrw nmap <buffer> l <Plug>NetrwLocalBrowseCheck" )
