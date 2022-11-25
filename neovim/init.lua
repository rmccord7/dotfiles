-- Autoinstall packer.nvim if not already installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd('packadd packer.nvim')
end

-- load impatient.nvim and compiled packer output before everything else
local impatient_ok, impatient = pcall(require, 'impatient')
if impatient_ok then
    impatient.enable_profile()
else
    print("couldn't load impatient.nvim")
end

local packer_compiled_ok = pcall(require, 'packer/packer_compiled')
if packer_compiled_ok then
    require('packer/packer_compiled')
end

require('global')
require('settings')
require('plugins')
require('mappings')
