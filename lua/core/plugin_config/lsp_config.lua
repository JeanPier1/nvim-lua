local agroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
end


require("mason-lspconfig").setup()

local function capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end


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
  capabilities = capabilities(),
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
  capabilities = capabilities(),
  init_options = { documentFormatting = true },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  filtetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}

require("lspconfig").solargraph.setup {
  capabilities = capabilities(),
}

require("lspconfig").pyright.setup {
  capabilities = capabilities(),
}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
}

require("lspconfig").tailwindcss.setup {
  -- on_attach = on_attach,
  capabilities = capabilities(),
}


require("lspconfig").flow.setup {
  capabilities = capabilities()
}

require("lspconfig").sourcekit.setup {
  capabilities = capabilities()
}

require("lspconfig").astro.setup {
  capabilities = capabilities()
}
require("lspconfig").emmet_ls.setup {
  -- on_attach = on_attach,
  capabilities = capabilities()
}
require("lspconfig").angularls.setup {
  on_attach = on_attach,
  capabilities = capabilities()
}

--capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").html.setup {
  capabilities = capabilities()
}


require("lspconfig").lua_ls.setup {
  capabilities = capabilities(),
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
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

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local function directory_exists(path)
  local f = io.popen("cd " .. path)
  local ff = f:read("*all")

  if ff:find("ItemNotFoundException") then
    return false
  else
    return true
  end
end
-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
if directory_exists(workspace_dir) then
else
  os.execute("mkdir " .. workspace_dir)
end

-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

require("lspconfig").jdtls.setup {
  capabilities = capabilities(),
  root_dir = root_dir,
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. install_path .. "/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    install_path .. "/config_" .. "win",
    "-data",
    workspace_dir,
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


-- vim.cmd [[
-- augroup Prettier
--   autocmd!
--   autocmd BufWritePre *.tsx,*.ts,*.js,*.html,*.css,*.scss
--   autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
-- augroup END
-- ]]
