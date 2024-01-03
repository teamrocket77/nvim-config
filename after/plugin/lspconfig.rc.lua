-- this file just exits out? should be more module all options should be self contained
-- check :messages for output if not functional
local ok, lspconfig = pcall(require, 'lspconfig')
if (not ok) then print("There was an issue using require on lspconfig plugin " )return end
local ok, lsp = pcall(require, 'lsp-zero')
if (not ok) then print("There was an issue using require on lsp-zero plugin ") return end
local ok, cmp = pcall(require, 'cmp')
if (not ok) then print("There was an issue using require on cmp plugin ") return end
local ok, mason_lsp = pcall(require, 'mason-lspconfig')
if (not ok) then print("There was an issue using require on mason-lsp plugin ") return end
local ok, mason = pcall(require, 'mason')
if (not ok) then print("There was an issue using require mason plugin ") return end
local ok, neodev = pcall(require, 'neodev')
if (not ok) then print("There was an issue using require neodev plugin ") return end

function get_lsp()
      local clients = vim.lsp.buf_get_clients()

    -- Use vim.inspect to convert the clients table to a human-readable string
    local client_info = vim.inspect(clients)

    -- Split the string into lines for display in the buffer
    local lines = vim.split(client_info, "\n")

    -- Create a new buffer for the LSP client output
    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    -- Set the buffer to be unlisted, no swap file, and read-only
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.readonly = true

    -- Move cursor to the first line
    vim.api.nvim_win_set_cursor(0, {1, 0})
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>buf', get_lsp, opts)

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
  "als",
  "bashls",
  "clangd",
  "cmake",
  "dockerls",
  "eslint",
  "gopls",
  'pyright',
  'rust_analyzer',
  'tsserver',
  'vimls',
  'jdtls',
}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp'},
    { name = 'nvim_lsp_signature_help'},
    { name = 'luasnip'},
    { name = 'path'},
    { name = 'nvim_lua'},
  }, {
    name = { 'buffer', keyword_length = 3 },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()


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

vim.diagnostic.config({
    virtual_text = true
})

lsp.setup()

-- local home = vim.env.HOME
-- 
-- local is_file_there = function()
--   local is_there=io.open(home .. '/.local/share/eclipse/eclipse-java-google-style.xml', "r")
--   if is_there~=nil then io.close(is_there) return true
--   else return false
--   end
-- end
-- 
-- local get_file = function()
--   if not is_file_there()
--     then
--     vim.fn.system{'curl',  "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml", '--create-dirs', home .. '.local/share/eclipse/eclipse-java-google-style.xml'}
--   end
-- end
-- 
-- local get_url = function()
--   get_file()
--   return {
--     url = ".local/share/eclipse/eclipse-java-google-style.xml",
--     profile = "GoogleStyle",
--   }
-- end
-- 
-- local jdtls_config = {
--   root_dir = vim.fs.dirname(vim.fs.find({
--     'gradle',
--     'mvnw',
--     '.git',
--     'main.java',
--     'Main.java'
--   })),
--   settings = (function()
--     if vim.env.JAVA_HOME == nil or vim.env.JAVA_HOME == '' then
--       return { }
--     else
--       return {
--         java = {
--           format = {
--             settings = {
--               get_url()
--             },
--           },
--           signatureHels = { enabled = true },
--           configuration = {
--             runtimes = {
--               {
--                 name = "JavaSE-17",
--                 path = vim.env.JAVA_HOME .. "/"
--               },
--             }
--           }
--         }
--       }
--     end
--   end)(),
--   bundles = {},
--   cmd = {
--     JAVA_HOME = vim.env.JAVA_HOME
--   }
-- }


neodev.setup({
})
local handlers = {
  ["yamlls"] = function ()
    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          keyordering = false
        }
      }
    }
  end,
  ["tsserver"] = function ()
    lspconfig.tsserver.setup {
      capabilities = capabilities,
    }
  end,
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          },
          diagnostics = {
            globals = { "vim"},
          },
        }
      }
    }
  end,
  ["rnix"] = function ()
    lspconfig.rnix.setup {
      capabilities = capabilities
    }
  end,
  ["gopls"] = function ()
    lspconfig.gopls.setup {
      capabilities = capabilities
    }
  end,
  ["rust-analyzer"] = function ()
    lspconfig.rust_analyzer.setup {
      capabilities = capabilities
    }
  end,
}

local default_config = function()
  return {
    capabilities = capabilities
  }
end

mason.setup()
mason_lsp.setup({
	handlers = {
          [1] = function(server)
            local config_func = handlers[server] or default_config
            config_func()
          end,
        }
})


