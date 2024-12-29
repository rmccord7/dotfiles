return {
  'coffebar/neovim-project',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
  init = function()
    vim.opt.sessionoptions:append('globals')
  end,
  opts = {
    projects = { -- define project roots
      '~/dotfiles/*',
      '~/dotfiles/neovim/*',
      '~/projects/*',
      '~/.config/*',
      '~/perforce/ganges/rel/*',
      '~/perforce/ganges/dev/*',
      require('rm.config.path').dev_plugins .. '/*',
    },
    last_session_on_startup = false,
    session_manager_opts = {
      autosave_ignore_filetypes = {
        'ccc-ui',
        'gitcommit',
        'gitrebase',
        'qf',
        'toggleterm',
        'lazy',
      },
    },
  },
  config = function(_, opts)
    require('neovim-project').setup(opts)

    vim.keymap.set({ 'n' }, '<leader>pd', ':Telescope neovim-project discover<CR>', { desc = 'Discover Projects' })
    vim.keymap.set({ 'n' }, '<leader>pj', ':Telescope neovim-project history<CR>', { desc = 'List Projects' })
  end,
}
