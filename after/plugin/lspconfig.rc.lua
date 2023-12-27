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

local handlers = {
   ["yamlls"] = function ()
       lspconfig.yamlls.setup {
	   settings = {
		   yaml = {
			   keyOrdering = false
		}
	   }
	}
   end,
   ["tsserver"] = function ()
       lspconfig.tsserver.setup {
       }
   end,
   ["lua_ls"] = function ()
       lspconfig.lua_ls.setup {
	   settings = {
	       Lua = {
		   diagnostics = {
		       globals = { "vim" }
		   }
	       }
	   }
       }
   end,
   ["rnix"] = function ()
       lspconfig.rnix.setup {
       }
   end,
   ["gopls"] = function ()
       lspconfig.gopls.setup {
       }
   end,
   -- ["jdtls"] = function ()
   --   lspconfig.jdtls.start_or_attach{
   --     jdtls_config
   --   }
   -- end,
 }

mason.setup()
mason_lsp.setup{
	ensure_installed = servers,
	handlers = {
          lsp.default_setup,
          handlers
        },
}
