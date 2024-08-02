return {
  {
    'zbirenbaum/copilot-cmp',
    event = 'InsertEnter',
    config = function()
      require('copilot_cmp').setup()
    end,
    dependencies = {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      config = function()
        require('copilot').setup {
          filetypes = {
            yaml = false,
            markdown = false,
          },
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      end,
    },
  },
}
