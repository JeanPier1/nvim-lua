-- local status, nvim_lsp = pcall(require, "lsconfig")
-- if (not status) then return end


local agroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = agroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = agroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end
  })
end


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }
  enable_format_on_save(client, bufnr)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end


require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspsaga').setup({
  code_action_icon = "💡",
  symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = ' ',
    show_file = true,
    file_formatter = ""
  },
  finder = {
    max_height = 0.6,
    keys = {
      vsplit = 'v'
    },
  },
  ui = {
    border = 'rounded',
  },
  lightbulb = {
    enable = false
  },
  outline = {
    layout = 'float'
  }
})

-- vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', { silent = true })
vim.keymap.set('n', 'K', "<Cmd>lua require('lspsaga.hover').render_hover_doc()")
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>");
vim.keymap.set("n", "<leader>lg", "<cmd>lua require'lspsaga.diagnostics'.show_line_diagnos()<CR>");
vim.keymap.set("n", "<c- ]>", "<cmd>lua vim.lsp.buf.definition()<CR>");

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

require("lspconfig").tsserver.setup {
  init_options = { documentFormatting = true },
  on_attach = on_attach,
  filtetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

require("lspconfig").solargraph.setup {
  capabilities = capabilities,
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
}
require("lspconfig").cssls.setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").tailwindcss.setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
}


require("lspconfig").flow.setup {
  capabilities = capabilities
}

require("lspconfig").sourcekit.setup {
  capabilities = capabilities
}

require("lspconfig").astro.setup {
  capabilities = capabilities
}
require("lspconfig").emmet_ls.setup {
  -- on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").angularls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").html.setup {
  capabilities = capabilities
}


require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      }
    }
  }
}


-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})


vim.cmd [[
augroup Prettier
  au!
  au BufWritePre *.tsx,*.ts,*.js,*.html,*.css,*.scss  Prettier
augroup END
]]
