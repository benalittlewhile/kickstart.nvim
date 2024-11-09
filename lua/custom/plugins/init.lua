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
}
