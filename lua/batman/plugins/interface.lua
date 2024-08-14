return {
  -- Shows buffers as tabs
  -- https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = function()
      local Offset = require 'bufferline.offset'
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local layout = require('edgy.config').layout
            local ret = { left = '', left_size = 0, right = '', right_size = 0 }
            for _, pos in ipairs { 'left', 'right' } do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = ' Sidebar' .. string.rep(' ', sb.bounds.width - 8)
                ret[pos] = '%#EdgyTitle#' .. title .. '%*' .. '%#WinSeparator#│%*'
                ret[pos .. '_size'] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
    config = function()
      require('bufferline').setup {}
    end,
  },

  -- Window manager
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      -- edgebar animations
      animate = {
        enabled = true,
        fps = 100, -- frames per second
        cps = 120, -- cells per second
        on_begin = function()
          vim.g.minianimate_disable = true
        end,
        on_end = function()
          vim.g.minianimate_disable = false
        end,
        -- Spinner for pinned views that are loading.
        -- if you have noice.nvim installed, you can use any spinner from it, like:
        -- spinner = require("noice.util.spinners").spinners.circleFull,
        spinner = {
          frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          interval = 80,
        },
      },
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = 'toggleterm',
          size = { height = 0.2 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ''
          end,
        },
        {
          ft = 'lazyterm',
          title = 'LazyTerm',
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        'Trouble',
        { ft = 'qf', title = 'QuickFix' },
        {
          ft = 'help',
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == 'help'
          end,
        },
      },
      left = {
        {
          title = function()
            local buf_name = vim.api.nvim_buf_get_name(0) or '[No Name]'
            return vim.fn.fnamemodify(buf_name, ':t')
          end,
          ft = 'Outline',
          pinned = true,
          open = 'SymbolsOutlineOpen',
        },
      },
    },
  },

  -- Statusline
  {
    'echasnovski/mini.statusline',
    opts = {},
  },

  -- UI replacement for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      popupmenu = {
        backend = 'cmp',
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
}
