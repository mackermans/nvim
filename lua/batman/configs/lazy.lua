-- Bootstrap lazy.nvim
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    -- import plugins
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    { import = 'batman.plugins' },
  },

  -- automatically check for plugin updates
  checker = { enabled = true },

  -- customize icons
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      favorite = ' ',
      ft = '📂',
      import = ' ',
      init = '⚙',
      keys = '🗝',
      lazy = '💤 ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
      loaded = '●',
      not_loaded = '○',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
    },
  },
}
