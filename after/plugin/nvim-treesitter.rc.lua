local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not ok) then print("There was an issue using pcall nvim-treesitter plugin ") return end

-- require'nvim-treesitter.configs'.setup{
treesitter.setup{
  ensure_installed = {"bash", "dockerfile", "rust", "scala", "markdown", "elixir", "yaml", "json", "c", "lua", "vim", "help", "ruby", "typescript", "python"},
  auto_install = true,
  textobjects = { enable = true };
  highlight = {
    enablee = true,

    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --   local max_filesize = 100 * 1024 -- 100 KB
    --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --   if ok and stats and stats.size > max_filesize then
    --     return true
    --   end
    -- end,
  }
}
