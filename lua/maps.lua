local keymap = vim.api.nvim_set_keymap
keymap ('n', '<c-s>', ':w<CR>', {})
keymap ('i', '<c-s>', '<Esc>:w<CR>a', {})
local opts = {noremap = true}
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

-- keymaps from here https://github.com/untitled-ai/jupyter_ascending.vim
keymap('n', '<space><space>x <Plug>', 'JupyterExecute', opts)
keymap('n', '<space><space>X <Plug>', 'JupyterExecuteAll', opts)
keymap('n', '<space><space>r <Plug>', 'JupyterRestart', opts)

-- https://github.com/mbbill/undotree#download-and-install
keymap('n', '<leader><F5>', 'vim.cmd.UndotreeToggle', opts)

local km = vim.keymap
km.set('n', '+', '<C-a>')
km.set('n', '-', '<C-x>')



local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", {noremap = false})
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

return M

