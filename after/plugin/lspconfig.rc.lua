local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

nvim_lsp['nil_ls'].setup{
}
nvim_lsp['solargraph'].setup{
	on_attach = on_attach,
}

nvim_lsp['asm_lsp'].setup{
        filetypes = { "asm", "s", "S", "vmasm" },
}

nvim_lsp['tsserver'].setup{
	on_attach = on_attach,
}

-- nvim_lsp.pyright.setup{
--   on_attach = on_attach,
--   settings = {
--     pyright = {
--       {autoImoprtCompletion = true,},
--       {
--         analysis = {
--           autoSearchPaths = true,
--           diagnosticMode = 'openFilesOnly',
--           useLibarayCodeForTypes = true,
--         }
--       }
--     }
--   }
--   -- local status, lsp = pcall(require, 'py_lsp')
--   -- if (not status) then return end
--   -- cmd_env = {venvPath: "./venv/bin/activate"} don't think this is needed since I active the env already
-- }

nvim_lsp['bashls'].setup{
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      }
    }
  }
}

nvim_lsp['yamlls'].setup{
	  filetypes = {
		  "sh", "zshrc"
	  },
}

nvim_lsp['rust_analyzer'].setup{
	on_attach = on_attach,
	-- Server-specific settings...
	settings = {
          ["rust-analyzer"] = {
            assist = {
              importEnforceGranularity = true,
              importPrefix = "crate"
            },
            cargo = {
              allFeatures = true
            },
            checkOnSave = {
              -- default: `cargo check`
              command = "clippy"
            },
          },
          inlayHints = {
            lifetimeElisionHints = {
              enable = true,
              useParameterNames = true
            },
          },
        }
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      }
    }
  }
}
require("mason").setup()
require("mason-lspconfig").setup{ 
  ensure_installed = {"pyright", "clangd", "cmake","dockerls"},
}
require("mason-lspconfig").setup_handlers({
  function(server_name)
    -- clangd is implied since i didn't specify it ++= cmake
    nvim_lsp[server_name].setup{
      on_attach = on_attach,
    }
  end,
  ["pyright"] = function()
    nvim_lsp.pyright.setup{
        on_attach = on_attach,
    }
  end
  })
local servers = {'yamlls', 'rust_analyzer', 'tsserver', 'asm_lsp', 'pyright', "clangd", "cmake", "dockerls"}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{
    capabilities = capabilities
  }
end
