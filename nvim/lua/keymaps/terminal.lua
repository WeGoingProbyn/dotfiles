local M = {}

-- Function to open a terminal window with fixed size and prevent buffer switching
function M.open_terminal()
  -- Open a horizontal split window and set its height
  vim.cmd("split | resize 20 | terminal")
  
  -- Get the current buffer and window IDs
  local term_buf = vim.api.nvim_get_current_buf()
  local term_win = vim.api.nvim_get_current_win()
  
  -- Set buffer options
  vim.bo[term_buf].buflisted = false
  vim.bo[term_buf].swapfile = false
  vim.bo[term_buf].filetype = 'bash-term'
  
  -- Prevent buffer switching in the terminal window
  vim.api.nvim_create_autocmd({'BufEnter'}, {
    buffer = term_buf,
    callback = function()
      if vim.api.nvim_get_current_win() == term_win then
        local buf_ft = vim.bo.filetype
        if buf_ft ~= 'bash-term' then
          vim.cmd('buffer ' .. term_buf)
        end
      end
    end,
  })
end

-- Function to close the terminal window
function M.close_terminal()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype
    if filetype == "bash-term" then
      -- Close the window and delete the buffer
      vim.api.nvim_win_close(win, true)
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
      -- Optionally, remove related autocommands if any
    end
  end
end

-- Function to toggle the terminal window
function M.toggle_terminal()
  local term_buf = nil
  local term_win = nil

  -- Search for an existing terminal window
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype
    if filetype == "bash-term" then
      term_buf = buf
      term_win = win
      break
    end
  end

  if term_win and vim.api.nvim_win_is_valid(term_win) then
    if vim.api.nvim_get_current_win() == term_win then
      -- Terminal is focused; close it
      M.close_terminal()
    else
      -- Terminal is open but not focused; focus it
      vim.api.nvim_set_current_win(term_win)
    end
  else
    -- Terminal is not open; open it
    M.open_terminal()
  end
end

-- Key mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Toggle terminal
-- map('n', '<A-t>', '<cmd>lua require"keymaps.terminal".toggle_terminal()<CR>', opts)
-- map('t', '<A-t>', '<cmd>lua require"keymaps.terminal".toggle_terminal()<CR>', opts)

-- Close terminal
-- map('n', '<A-t><A-q>', '<cmd>lua require"keymaps.terminal".close_terminal()<CR>', opts)
-- map('t', '<A-t><A-q>', '<cmd>lua require"keymaps.terminal".close_terminal()<CR>', opts)

return M

