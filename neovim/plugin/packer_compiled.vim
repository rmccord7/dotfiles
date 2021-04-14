" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "C:\\Users\\rmccord\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\rmccord\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\rmccord\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\rmccord\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\rmccord\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["barbar.nvim"] = {
    config = { "require('config.barbar')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\barbar.nvim"
  },
  cmake4vim = {
    config = { "require('config.cmake')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmake4vim"
  },
  ["hop.nvim"] = {
    config = { "require('config.hop')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hop.nvim"
  },
  indentLine = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\indentLine"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('config.lualine')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim"
  },
  ["nvim-compe"] = {
    config = { "require('config.compe')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require('config.lsp')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "require('config.tree')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.treesitter')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"
  },
  playground = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim"
  },
  tcomment_vim = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tcomment_vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim"
  },
  ["vim-easy-align"] = {
    config = { "require('config.easy-align')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive"
  },
  ["vim-perforce"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-perforce"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-repeat"
  },
  ["vim-rooter"] = {
    config = { "require('config.rooter')" },
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rooter"
  },
  ["vim-signify"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-signify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "C:\\Users\\rmccord\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-unimpaired"
  }
}

-- Config for: barbar.nvim
require('config.barbar')
-- Config for: nvim-lspconfig
require('config.lsp')
-- Config for: lualine.nvim
require('config.lualine')
-- Config for: nvim-tree.lua
require('config.tree')
-- Config for: vim-rooter
require('config.rooter')
-- Config for: vim-easy-align
require('config.easy-align')
-- Config for: cmake4vim
require('config.cmake')
-- Config for: hop.nvim
require('config.hop')
-- Config for: nvim-compe
require('config.compe')
-- Config for: nvim-treesitter
require('config.treesitter')
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
