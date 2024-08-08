return {
  -- Enhance native comments with treesitter
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },

  -- Highlight colors
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        filetypes = { '*' },
        user_default_options = {
          RGB = true, -- #RGB hex codes: #FA0
          RRGGBB = true, -- #RRGGBB hex codes: #FF0000
          names = true, -- "Name" codes: Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes: #FF000055
          rgb_fn = true, -- CSS rgb() and rgba() functions: rgb(0, 0, 255) rgba(0, 255, 0, 0.5)
          hsl_fn = true, -- CSS hsl() and hsla() functions: hsl(120, 100%, 70%)
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          tailwind = true, -- Enable tailwind color utility classes: text-indigo-500
          -- Available modes: foreground, background
          mode = 'background', -- Set the display mode.
        },
      }
    end,
  },

  -- Show code context
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 3,
    },
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    config = function()
      local api = vim.api

      local exclude_ft = { 'help', 'git', 'markdown', 'snippets', 'text', 'gitconfig', 'alpha', 'dashboard' }

      require('ibl').setup {
        indent = {
          -- -- U+2502 may also be a good choice, it will be on the middle of cursor.
          -- -- U+250A is also a good choice
          char = '▏',
        },
        scope = {
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = exclude_ft,
          buftypes = { 'terminal' },
        },
      }

      local gid = api.nvim_create_augroup('indent_blankline', { clear = true })
      api.nvim_create_autocmd('InsertEnter', {
        pattern = '*',
        group = gid,
        command = 'IBLDisable',
      })

      api.nvim_create_autocmd('InsertLeave', {
        pattern = '*',
        group = gid,
        callback = function()
          if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
            vim.cmd [[IBLEnable]]
          end
        end,
      })
    end,
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = 'all',
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
