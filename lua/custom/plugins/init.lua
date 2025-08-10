--
-- Keybinds
--

-- Make ctrl + j/k switch command line suggestions like it does for insert
vim.keymap.set('c', '<C-j>', '<C-n>', { desc = 'Select next command line completion' })
vim.keymap.set('c', '<C-k>', '<C-p>', { desc = 'Select previous command line completion' })

-- make space v t open a new terminal in a vertical split
vim.keymap.set('n', '<Leader>vt', ':vert<Space>term<cr>', { silent = true })

-- make space v s open a new vertical split
vim.keymap.set('n', '<Leader>vs', ':vsp<cr>', { silent = true })

-- trying to make normal mode esc clear search results (this is technically in
-- the kickstart template already, idk why it needs to be defined here)
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--
-- Other vim settings
--

-- word wrap and such
vim.o.textwidth = 80
-- vim.o.shiftwidth = 4
-- vim.o.tabstop = 4
vim.opt.list = false

-- don't fold by default (gross)
vim.o.foldlevel = 99

-- set fold method (should change once 0.11 is out)
vim.o.foldmethod = 'indent'
-- try built in lsp folding (THIS WILL BECOME ACTIVE WITH NVIM 0.11 RELEASE IN
-- MARCH 2025)
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

-- disable diagnostics inline (instead use 'gh' to trigger hover.nvim)
vim.diagnostic.config { virtual_text = false }

-- set zsh as shell (hopefully so !<command> inherits the same settings)
vim.o.shell = '/bin/zsh'
vim.o.shellcmdflag = '-ic'

-- Plugins
return {
  {
    'kaicataldo/material.vim',
    init = function()
      vim.cmd.colorscheme 'material'
      -- I want just the background color to match my usual
      vim.cmd [[
        hi normal guibg=283137
        hi normalfloat guibg=283137
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
  --
  -- DISABLING NULL LS BECAUSE IT WAS MAKING PRETTIER MISBEHAVE AND THAT'S BAD
  --
  -- {
  --   'nvimtools/none-ls.nvim',
  --   dependencies = {
  --     'nvimtools/none-ls-extras.nvim',
  --   },
  --   config = function()
  --     local null_ls = require 'null-ls'
  --
  --     local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
  --     local event = 'BufWritePre' -- or "BufWritePost"
  --     local async = event == 'BufWritePost'
  --
  --     null_ls.setup {
  --       on_attach = function(client, bufnr)
  --         if client.supports_method 'textDocument/formatting' then
  --           vim.keymap.set('n', '<Leader>f', function()
  --             vim.lsp.buf.format { bufnr = vim.api.nvim_get_current_buf() }
  --           end, { buffer = bufnr, desc = '[lsp] format' })
  --
  --           -- format on save
  --           vim.api.nvim_clear_autocmds { buffer = bufnr, group = group }
  --           vim.api.nvim_create_autocmd(event, {
  --             buffer = bufnr,
  --             group = group,
  --             callback = function()
  --               vim.lsp.buf.format { bufnr = bufnr, async = async }
  --             end,
  --             desc = '[lsp] format on save',
  --           })
  --         end
  --
  --         if client.supports_method 'textDocument/rangeFormatting' then
  --           vim.keymap.set('x', '<Leader>f', function()
  --             vim.lsp.buf.format { bufnr = vim.api.nvim_get_current_buf() }
  --           end, { buffer = bufnr, desc = '[lsp] format' })
  --         end
  --       end,
  --       sources = {
  --         null_ls.builtins.formatting.prettier,
  --         null_ls.builtins.formatting.black,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   'MunifTanjim/prettier.nvim',
  --   init = function()
  --     local prettier = require 'prettier'
  --     prettier.setup {
  --       bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
  --       filetypes = {
  --         'css',
  --         'graphql',
  --         'html',
  --         'javascript',
  --         'javascriptreact',
  --         'json',
  --         'less',
  --         'markdown',
  --         'scss',
  --         'typescript',
  --         'typescriptreact',
  --         'yaml',
  --       },
  --     }
  --   end,
  -- },
  {
    'lewis6991/hover.nvim',
    init = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require 'hover.providers.lsp'
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.fold_preview')
          require 'hover.providers.diagnostic'
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'single',
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'LSP',
        },
        mouse_delay = 1000,
      }

      -- Setup keymaps
      -- gh hovers like vs code
      vim.keymap.set('n', 'gh', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gH', require('hover').hover_select, { desc = 'hover.nvim (select)' })
      vim.keymap.set('n', '<C-p>', function()
        require('hover').hover_switch 'previous'
      end, { desc = 'hover.nvim (previous source)' })
      vim.keymap.set('n', '<C-n>', function()
        require('hover').hover_switch 'next'
      end, { desc = 'hover.nvim (next source)' })
      -- I had previously copied the above functions to map c-j and c-k to the
      -- same thing, but that apparently conflicts with normal mode movements,
      -- so that's out lol
      vim.keymap.set('n', '<esc>', function()
        require('hover').close(0)
        -- APPARENTLY THIS HAS TO BE SET HERE BECAUSE KEYMAP.SET IS EXCLUSIVE
        -- ISN'T THAT AWESOME I LOVE THAT SO MUCH
        vim.cmd.nohlsearch() -- clear hl search on escape
      end)

      -- Mouse support
      vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
      vim.o.mousemoveevent = true
    end,
  },
}
