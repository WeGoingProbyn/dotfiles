-- Define an array of special characters
local specialCharacters = {'#', '%', '&', '@', '!', '$', '*', '(', ')'}

-- Function to move the cursor to the next special character
function move_cursor()
  -- Get the current cursor position (line and column)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = vim.api.nvim_get_current_line()

  -- Adjust the column to be 1-indexed in Lua
  col = col + 1

  -- Initialize variables to find the nearest special character
  local nearest_pos = nil
  local line_length = #current_line

  -- Iterate through each special character and find the nearest one
  for _, char in ipairs(specialCharacters) do
    local pos = string.find(current_line:sub(col), "%f[%w]" .. char, 1, true)
    if pos then
      pos = pos + col - 1  -- Adjust pos to be absolute position in the line
      if not nearest_pos or pos < nearest_pos then
        nearest_pos = pos
      end
    end
  end

  if nearest_pos then
    -- Move cursor to the nearest special character (considering 0-indexing in vim)
    vim.api.nvim_win_set_cursor(0, {line, nearest_pos - 1})
  else
    -- Optionally, move cursor to the end of the line if no special character is found
    vim.api.nvim_win_set_cursor(0, {line, line_length})
  end
end


map = vim.api.nvim_set_keymap
opts = { noremap = true, silent = true }

map('n', '<C-Right>', ':lua move_cursor()<CR>', opts)
