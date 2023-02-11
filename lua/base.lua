-- vim.cmd('autocmd!')
vim.cmd('set encoding=utf-8')

vim.wo.number = true
vim.wo.rnu = true
vim.opt.hlsearch = true
vim.opt.showcmd = true
vim.opt.ignorecase = true 
vim.opt.path:append { '**' } --Finding files - searching down 
vim.opt.wildignore:append { '*/node_modules*' } --
-- vim.g.python3_host_prog = '/Users/vvvv/.pyenv/versions/pyvimenv/bin/python'
