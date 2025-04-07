-- config.lspconfig.lua
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Function to run when LSP connects to a buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Buffer local mappings.
  local opts = { noremap=true, silent=true }
  local buf_set_keymap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- LSP keybindings
  buf_set_keymap('n', '<C-a>', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_set_keymap('n', '<C-d><C-e>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
end

-- Update capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup LSP servers
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

