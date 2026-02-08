-- Keymaps + buffer options when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    -- completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<C-a>", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-d><C-e>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
  end,
})

-- Capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure servers (Neovim 0.11+)
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
})

vim.lsp.config("clangd", {
  capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allTargets = true,
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      procMacro = { enable = true },

      checkOnSave = true,
      check = {
        command = "clippy",
        extraArgs = {
          "--",
          "-W", "clippy::all",
        },
      },
    },
  },
})


-- Enable the servers you want
vim.lsp.enable({ "lua_ls", "pyright", "clangd", "rust_analyzer" })

-- Diagnostics (only configure once)
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },
  virtual_text = { prefix = "●" },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

