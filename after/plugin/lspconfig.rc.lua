-- this file just exits out? should be more module all options should be self contained
-- check :messages for output if not functional
local ok, _ = pcall(require, 'lspconfig')
if (not ok) then print("There was an issue using require on lspconfig plugin " )return end
local ok, lsp = pcall(require, 'lsp-zero')
if (not ok) then print("There was an issue using require on lsp-zero plugin ") return end
local ok, cmp = pcall(require, 'cmp')
if (not ok) then print("There was an issue using require on cmp plugin ") return end
local ok, mason_lsp = pcall(require, 'mason-lspconfig')
if (not ok) then print("There was an issue using require on mason-lsp plugin ") return end
local ok, mason = pcall(require, 'mason')
if (not ok) then print("There was an issue using require mason plugin ") return end


local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Configure linter here
-- TODO way to autoinstall
local linters = {
  -- linters
  "eslint_d",
  "pylint",
  "asm-lsp",
  "yamllint",
}

local servers = {'yamlls',
  -- lsp
  "clangd",
  "cmake",
  "dockerls",
  "bashls",
  "eslint",
  "rnix",
  "solargraph",
  "golangci_lint_ls",
  "sumneko_lua",
  "als",
  'pyright',
  'rust_analyzer',
  'tsserver',
  'vimls',
}
mason_lsp.setup{
	ensure_installed = servers
}

local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- old line ^^  would like this to be really porable
lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})
 -- some v cool maps stolen from the primagen
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.preset('recommended')
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('tsserver', {
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true
    })
  }
})
vim.diagnostic.config({
    virtual_text = true
})

mason.setup()
lsp.setup()
