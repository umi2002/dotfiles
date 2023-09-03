vim.cmd("autocmd FileType netrw nmap <buffer> <silent> <C-l> :wincmd l<CR>")
vim.cmd("autocmd FileType netrw nmap <buffer> <silent> <C-h> :wincmd h<CR>")
vim.cmd("autocmd FileType netrw nmap <buffer> <silent> <C-k> :wincmd k<CR>")
vim.cmd("autocmd FileType netrw nmap <buffer> <silent> <C-j> :wincmd j<CR>")

vim.cmd("autocmd FileType netrw nmap <buffer> h <Plug>NetrwBrowseUpDir")
vim.cmd("autocmd FileType netrw nmap <buffer> l <Plug>NetrwLocalBrowseCheck")
