local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Moving in normal mode
map('n', 'q', 'b', opts)

-- Move lines
map('n', '<A-Up>', ':m .-2<CR>==', opts)
map('i', '<A-Up>', '<Esc>:m .-2<CR>==', opts)

map('n', '<A-Down>', ':m .+1<CR>==', opts)
map('i', '<A-Down>', '<Esc>:m .+1<CR>==', opts)

-- Move visual blocks
map('v', '<A-Up>', ':m \'<-2<CR>gv=gv', opts)
map('v', '<A-Down>', ':m \'>+1<CR>gv=gv', opts)

-- Visual mode block selection
map('x', '<S-Right>', '<C-v><Right>', opts)
map('x', '<S-Left>', '<C-v><Left>', opts)

map('x', '<S-Up>', '<C-v><Up>', opts)
map('x', '<S-Down>', '<C-v><Down>', opts)

-- Move between buffers
-- map('n', '<S-Tab>', ':BufferLineCycleNext<CR>', opts)
-- map('n', '<S-Tab><S-Tab>', ':BufferLineCyclePrev<CR>', opts)

-- Buffer navigation
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprev<CR>', opts)

-- toggle nvim tree into cursor focus
map('n', '<A-t>', ':wincmd p<CR>', opts)
