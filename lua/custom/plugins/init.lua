-- Keybinds

-- Make ctrl + j/k switch command line suggestions like it does for insert
vim.keymap.set('c', '<C-j>', '<C-n>', { desc = 'Select next command line completion' })
vim.keymap.set('c', '<C-k>', '<C-p>', { desc = 'Select previous command line completion' })

-- make space v t open a new terminal in a vertical split
vim.keymap.set('n', '<Leader>vt', ':vert<Space>term<cr>', { silent = true })

-- make space v s open a new vertical split
vim.keymap.set('n', '<Leader>vs', ':vsp<cr>', { silent = true })

-- Other vim settings

-- word wrap and such
vim.o.textwidth = 80
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.opt.list = false

-- Plugins
return {
  {
    'kaicataldo/material.vim',
    init = function()
      vim.cmd.colorscheme 'material'
      -- I want just the background color to match my usual
      vim.cmd [[
        hi normal guibg=283137
        hi signcolumn guibg=283137
      ]]
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },
  {
    -- replaces tpope/vim-sleuth to hopefully work better
    'NMAC427/guess-indent.nvim',
  },
  {
    'windwp/nvim-ts-autotag',
    init = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        -- per_filetype = {
        --   ['html'] = {
        --     enable_close = false,
        --   },
        -- },
      }
    end,
  },
}
