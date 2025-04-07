local M = {}

M.plugins = {
	-- Theme
	{
		'loctvl842/monokai-pro.nvim',
		lazy = false,
    opts = function()
      return require('config.monokai')
    end,
		config = function(_, opts)
      require('monokai-pro').setup(opts)
      vim.cmd([[colorscheme monokai-pro]])
		end,
	},

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
		config = function()
		end,
  },

  {
    "nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
      require("nvim-web-devicons").setup()
		end,
 	},

  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = require('config.comment'),
    config = function()
      require("Comment").setup()
    end,
  },

	{
    "nvim-tree/nvim-tree.lua",
		lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
   	  return require "config.nvimtree"
		end,
		config = function(_, opts)
      require("nvim-tree").setup(opts)
		end,
  },

  {
    'mfussenegger/nvim-dap',
    lazy = false,
    config = function()
      require('config.dap')
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    lazy = false,
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = false,
    config = function()
      require('nvim-dap-virtual-text').setup()
    end,
  },

  {
    'nvim-lua/plenary.nvim',
    config = function()
    end,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = function()
      return require('config.masonconfig')
    end,
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup(require('config.mason_lspconfig'))
    end,
  },
 
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require('config.lspconfig')
    end,
  },
  
  -- Optional: Autocompletion and snippets
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require("config.cmp")
    end
  },

  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    'rafamadriz/friendly-snippets',
    lazy = true,
    config = function()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      return require('config.lualine')
    end,

    config = function(_, opts)
      require('lualine').setup(opts)
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
		opts = function()
      return require('config.treesitter')
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(require('config.treesitter'))
    end,
  },

  -- Optional: Additional modules for integration
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    lazy = true,
    config = function()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
    config = function()
    end,
  },
  {
    'RRethy/nvim-treesitter-endwise',
    lazy = true,
    config = function()
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    config = function()
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup({
        indent = { char = "│" },
        scope = { char = "│" },
      })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    opts = function()
      return require('config.telescope')
    end,
    config = function()
      require('telescope').setup(require('config.telescope'))
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = "nvim_lsp",
          offsets = {
            {
            filetype = "NvimTree",
            highlight = "Directory",
            text_align = "left",
            text = function()
              local handle = io.popen('pwd')
              local result = handle:read('*a')
              handle:close()
              local current_directory = result:match(".*/(.*)")
              return "  " .. current_directory:sub(1, -2)
            end,
            }
          },
          custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "terminal" and vim.bo[buf_number].filetype ~= "bash" then
              return true
            end
          end,
        }
      })
	  end,
  },
}

return M
