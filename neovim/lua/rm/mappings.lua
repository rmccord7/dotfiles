local global = require("rm.global")

-- Remap space as leader key
--map('', '<Space>', '<Nop>', 'Leader')
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n" }, "<leader>pc", [[<cmd>Telescope p4 clients<cr>]], { desc = "List perforce clients" })
vim.keymap.set({ "n" }, "<leader>pl", [[<cmd>Telescope p4 change_lists<cr>]], { desc = "List perforce change lists" })

vim.keymap.set({ "n" }, "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set({ "n" }, "<leader>qf", "<cmd>qa!<cr>", { desc = "Force Quit all" })

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
vim.keymap.set({ "n" }, "Q", "@@", { desc = "Repeat last macro" })

-- Map jk/kj to <esc>. Note that this causes small visual pauses when actually
-- typing j or k
vim.keymap.set({ "i" }, "jk", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set({ "i" }, "kj", "<ESC>", { desc = "Exit insert mode" })

-- Keep cursor centered on search, motions, and join.
vim.keymap.set({ "n" }, "n", "nzzzv")
vim.keymap.set({ "n" }, "N", "Nzzzv")
vim.keymap.set({ "n" }, "g;", "g;zz")
vim.keymap.set({ "n" }, "gi", "zzgi")
vim.keymap.set({ "n" }, "J", "mzJ'z")
vim.keymap.set({ "n" }, "[c", "[czz")
vim.keymap.set({ "n" }, "]c", "]czz")
vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n" }, "<C-f>", "<C-f>zz")
vim.keymap.set({ "n" }, "<C-b>", "<C-b>zz")

vim.keymap.set({ "n" }, "<leader>ht", [[:lua require('lsp-inlayhints').toggle()<CR>]])
vim.keymap.set({ "n" }, "<leader>hc", [[:lua require('lsp-inlayhints').reset()<CR>]])

-- Don't undo everything.
vim.keymap.set({ "i" }, ".", ".<c-g>u")
vim.keymap.set({ "i" }, ",", ",<c-g>u")
vim.keymap.set({ "i" }, "!", "!<c-g>u")
vim.keymap.set({ "i" }, "?", "?<c-g>u")

-- Return from relative number jumping.
vim.keymap.set({ "n" }, "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true, desc = "Move line down" })
vim.keymap.set({ "n" }, "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true, desc = "Move line up" })

--Moving text
vim.keymap.set({ "v" }, "J", [[:m '>+1<CR>gv=gv]], { desc = "Move text down" })
vim.keymap.set({ "v" }, "K", [[:m '<-2<CR>gv=gv]], { desc = "Move text up" })
vim.keymap.set({ "i" }, "<C-j>", [[<esc>:m .+1<CR>==]], { desc = "Move text up" })
vim.keymap.set({ "i" }, "<C-k>", [[<esc>:m .-2<CR>==]], { desc = "Move text down" })
vim.keymap.set({ "n" }, "<leader>k", [[:m .-2<CR>==]], { desc = "Move line up" })
vim.keymap.set({ "n" }, "<leader>j", [[:m .+1<CR>==]], { desc = "Move line down" })

-- make c/C change command send text to black hole register, i didn't want
-- it anyways if I changed it probably
vim.keymap.set({ "n" }, "c", '"_c')
vim.keymap.set({ "n" }, "C", '"_C')

-- Change word. Set next word for quick search/replace..
vim.keymap.set({ "n" }, "cn", [[*''cgn]], { desc = "Change next word" })
vim.keymap.set({ "n" }, "cN", [[*''cgN]], { desc = "Change next word" })

-- Reselect last put text
vim.keymap.set({ "n" }, "gV", "'[v']", { desc = "Select last put text" })

-- Replace currently selected text with default register without yanking it
vim.keymap.set({ "v" }, "p", '"_dP', { silent = false })

-- Insert new line without leaving normal mode.
vim.keymap.set({ "n" },
  "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { nowait = true, desc = "Insert new line below" }
)
vim.keymap.set({ "n" },
  "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { nowait = true, desc = "Insert new line above" }
)

-- run a :command
vim.keymap.set({ "n", "v" }, "go", ":", { silent = false, desc = "Command-line mode" })

-- Substitute Linewise
vim.keymap.set({ "n", "v" }, "<leader>sl", ":s/", { silent = false, desc = "Linewise search" })

-- Substitute Globally
vim.keymap.set({ "n", "v" }, "<leader>sg", ":%s/", { silent = false, desc = "Global buffer search" })

-- repeat last macro
vim.keymap.set({ "n", "v" }, "<c-m>", "@@", { silent = false, desc = "Repeat last macro" })

-- repeat last :command
vim.keymap.set({ "n", "v" }, "gx", "@:", { silent = false, desc = "Repeat last command" })

-- remap q: to be easier to use, less work for your poor left pinky
vim.keymap.set({ "n", "v" }, "<c-q>", "q:", { silent = false, desc = "Open cmdline window" })

-- quickfix list navigation yay
vim.keymap.set({ "n" }, "<leader>co", "<cmd>copen<cr>", { desc = "Open qflist" })
vim.keymap.set({ "n" }, "<leader>ce", "<cmd>cclose<cr>", { desc = "Close/exit qflist" })
vim.keymap.set({ "n" }, "<leader>cn", "<cmd>cnext<cr>", { desc = "Next item in qflist" })
vim.keymap.set({ "n" }, "<leader>cp", "<cmd>cprev<cr>", { desc = "Prev item in qflist" })
vim.keymap.set({ "n" }, "<leader>qd", function()
  vim.ui.input({ prompt = "Quickfix do: ", completion = "command" }, function(do_cmd)
    if do_cmd then
      vim.cmd("cfdo " .. do_cmd)
    end
  end)
end, { desc = "Exec cmd for all items in qf list" })

-- take the only existing window and split it to the right
vim.keymap.set({ "n" }, "<leader>wr", [[<cmd>vnew | wincmd r | wincmd l<cr>]], { desc = "Split 1 window to right" })

-- swap windows and move cursor to other window
vim.keymap.set({ "n" }, "<leader>wl", [[<cmd>wincmd r | wincmd l<cr>]], { desc = "Swap windows and move cursor" })

-- Toggle relative line numbers
vim.keymap.set({ "n" }, "<leader>tn", function()
  if vim.api.nvim_get_option_value("relativenumber", { buf = 0 }) then
    vim.cmd("windo set norelativenumber")
  else
    vim.cmd("windo set relativenumber")
  end
end, { desc = "Toogle relative line numbers" })

-- Reload current buffer if it is a vim or lua file (Source Here)
vim.keymap.set({ "n" }, "<leader>sh", function()
  local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  if ft == "vim" then
    vim.cmd("source %")
    vim.notify("vim file reloaded!", vim.log.levels.INFO)
  elseif ft == "lua" then
    vim.cmd("luafile %")
    vim.notify("lua file reloaded!", vim.log.levels.INFO)
  else
    vim.notify("Not a lua or vim file", vim.log.levels.INFO)
  end
end, { desc = "Source Here (reload current file)" })

-- Search dev docs
vim.keymap.set({ "n" }, "<leader>dd", function()
  local query = vim.fn.input({ default = "Search DevDocs: " })
  local encodedURL = nil

  if global.os_open_cmd ~= "" then
    encodedURL = global.os_open_cmd .. string.format(' "https://devdocs.io/#q=%s"', query:gsub("%s", "%%20"))

    os.execute(encodedURL)
  else
    vim.notify("Open command not supported by OS", vim.log.levels.ERROR)
  end
end, { desc = "Search DevDocs" })

-- Change a split between horizontal and vertical
vim.keymap.set({ "n" }, "<leader>ws", function()
  local a = vim.api
  local windows = a.nvim_tabpage_list_wins(0)

  if #windows ~= 2 then
    vim.notify("Only works for 2 splits", vim.log.levels.ERROR)
    return
  end

  local ui = a.nvim_list_uis()[1]
  local win1_height = a.nvim_win_get_height(windows[1])
  local win2_height = a.nvim_win_get_height(windows[2])

  local cmd_mapping
  if ui.height < win1_height + win2_height then
    cmd_mapping = a.nvim_replace_termcodes("<c-w>K", true, false, true)
  else
    cmd_mapping = a.nvim_replace_termcodes("<c-w>L", true, false, true)
  end

  if cmd_mapping then
    a.nvim_feedkeys(cmd_mapping, "n", false)
  end
end, { desc = "Swap split between horizontal and vertical" })
