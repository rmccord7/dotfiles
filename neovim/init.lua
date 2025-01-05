-- Make sure to setup `mapleader` and `maplocalleader` before all other things
-- so that all keymaps use the correct <leader> and <localleader> key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.minimal = vim.env.VIM_MIN ~= nil or vim.g.minimal ~= nil

require('rm.global')
require('rm.config')
require('rm.settings')
require('rm.mappings')
require('rm.auto')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
end

-- Add lazy to the runtime.
vim.opt.rtp:prepend(lazypath)

local path = require('rm.config.path')
local path_util = require('rm.util.path')

--- @type LazyConfig opts
local opts = {
  spec = vim.g.minimal and {
    { import = 'rm.plugins.material' },
  } or {
    { import = 'rm.plugins' },
  },
  dev = {
    path = path_util.os_path(path.nvim_data .. '/dev'),
    fallback = true,
  },
  install = {
    colorscheme = { 'material' },
  },
  diff = {
    cmd = 'diffview.nvim',
  },
  rtp = {
    disabled_plugins = require('rm.disable_rtp_plugins'),
  },
}

require('lazy').setup(opts)

vim.keymap.set({ 'n' }, '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Lazy.nvim UI' })
