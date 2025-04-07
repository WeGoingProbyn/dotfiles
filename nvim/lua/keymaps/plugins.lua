map = vim.api.nvim_set_keymap
opts = { noremap = true, silent = true }

map('n', '<C-f>', ':Telescope current_buffer_fuzzy_find<CR>', opts)
map('n', '<C-f><C-f>', ':lua require("telescope.builtin").grep_string()<CR>', opts)


map('n', '<F5>', ":lua require('dap').continue()<CR>", opts)
map('n', '<F9>', ":lua require('dap').toggle_breakpoint()<CR>", opts)
map('n', '<F10>', ":lua require('dap').step_over()<CR>", opts)
map('n', '<F11>', ":lua require('dap').step_into()<CR>", opts)
map('n', '<F12>', ":lua require('dap').step_out()<CR>", opts)

map('n', '<F6>', ":lua require('dapui').open()<CR>", opts)
