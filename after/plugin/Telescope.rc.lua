local ok, t_builtin = pcall(require, 'telescope.builtin')
if not ok then
	print("Telescope is not installed")
end

local keyset = vim.keymap.set

keyset("n", "<leader>gre", t_builtin.live_grep, {})
keyset("n", "<leader>ggg", t_builtin.grep_string, {})
keyset("n", "<leader>commit", t_builtin.git_commits, {})
keyset("n", "<leader>bcommit", t_builtin.git_bcommits, {})
keyset("n", "<leader>status", t_builtin.git_bcommits, {})

