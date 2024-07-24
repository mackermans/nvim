return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other plugins start.
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
