function cargo_build()
    local handle = io.popen('cargo build 2>&1', 'r') -- Run cargo build and capture stdout and stderr
    local result = handle:read("*a") -- Read the entire output
    handle:close()

    -- Create a new buffer and set its lines to the command output
    vim.cmd("new")

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.readonly = true

    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, "\n"))
end

function cargo_test()
    local handle = io.popen('cargo test 2>&1', 'r') -- Run cargo build and capture stdout and stderr
    local result = handle:read("*a") -- Read the entire output
    handle:close()

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.readonly = true

    -- Create a new buffer and set its lines to the command output
    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, "\n"))
end

-- Set the keymap to call the cargo_build function
vim.api.nvim_set_keymap('n', 'build', ':lua cargo_build()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'test', ':lua cargo_test()<CR>', { noremap = true, silent = true })
