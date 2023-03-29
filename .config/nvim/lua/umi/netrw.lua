vim.cmd('autocmd FileType netrw nmap <buffer> <C-l> :wincmd l<CR>')
vim.cmd('autocmd FileType netrw nmap <buffer> <C-h> :wincmd h<CR>')
vim.cmd('autocmd FileType netrw nmap <buffer> <C-k> :wincmd k<CR>')
vim.cmd('autocmd FileType netrw nmap <buffer> <C-j> :wincmd j<CR>')

vim.api.nvim_set_keymap('n', 'h', '<Plug>NetrwBrowseUpDir', {})
vim.api.nvim_set_keymap('n', 'l', '<Plug>NetrwLocalBrowseCheck', {})
