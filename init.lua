
local is_mac = "macunix"
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.cmd [[ set mouse=a ]]
vim.cmd [[ let g:python3_host_prog = '/Users/vincentcradler/.pyenv/versions/pynvim/bin/python'  ]]
vim.cmd [[ let g:ruby_host_prog = '/Users/vincentcradler/.rbenv/versions/3.1.0/bin/ruby'  ]]
-- 
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true}
keyset('n', '<c-s>', ':w<CR>', {})
keyset('i', '<c-s>', '<Esc>:w<CR>a', {})
keyset('n', '<c-j>', '<c-w>j', opts)
keyset('n', '<c-h>', '<c-w>h', opts)
keyset('n', '<c-k>', '<c-w>k', opts)
keyset('n', '<c-l>', '<c-w>l', opts)

local t_builtin = require('telescope.builtin')
keyset("n", "<leader>gre", t_builtin.live_grep, {})
keyset("n", "<leader>ggg", t_builtin.grep_string, {})
keyset("n", "<leader>commit", t_builtin.git_commits, {})
keyset("n", "<leader>bcommit", t_builtin.git_bcommits, {})
keyset("n", "<leader>status", t_builtin.git_bcommits, {})

require('base')
require('macos')
require ('plugins')
require('maps')

