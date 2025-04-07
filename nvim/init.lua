local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("nvim_opts")
require("keymaps.cursor")
require("keymaps.editor")
require("keymaps.terminal")
require("keymaps.plugins")

local plugins = require("plugins").plugins
require("lazy").setup(plugins, require("config.lazy"))

for _, plugin in ipairs(plugins) do
  plugin.config()
end
