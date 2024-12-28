local actions = require("telescope.actions")

local always_ignored = {
  -- Directories
  "%.git/.*",

  -- Clangd
  "%.cache/*",

  -- FileTypes
  "$%.ttf",
  "$%.svg",
  "$%.png",
  "$%.jpeg",
  "$%.jpg",
  "$%.ico",

  -- Files
  "tags",

  -- Output files
  "$%.o",
  "$%.a",
  "$%.lib",
  "$%.so",
  "$%.bin",
  "$%.elf",
  "$%.dblite",
  "$%.pyc",
}

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "LinArcX/telescope-env.nvim",
    "tsakirist/telescope-lazy.nvim",
    "rmccord7/p4.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope-frecency.nvim",
  },
  event = "VeryLazy",
  opts = {
    pickers = {
      live_grep = {
        path_display = { "truncate" },
        file_ignore_patterns = always_ignored,
      },

      git_commits = {
        selection_strategy = "row",
        prompt_title = "git log",
      },

      buffers = {
        path_display = { "smart" },
        show_all_buffers = true,
        attach_mappings = function(_, local_map)
          local_map("n", "d", actions.delete_buffer)
          local_map("i", "<c-x>", actions.delete_buffer)
          return true
        end,
      },

      git_branches = {
        attach_mappings = function(_, local_map)
          local_map("i", "<c-o>", actions.git_checkout)
          local_map("n", "<c-o>", actions.git_checkout)
          return true
        end,
        selection_strategy = "row",
      },

      find_files = {
        path_display = { "smart" },
        find_command = { "rg", "--files", "-L" },
        hidden = true,
      },

      oldfiles = {
        path_display = { "smart" },
      },
    },
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      mappings = {
        n = {
          ["jk"] = actions.close,
          ["kj"] = actions.close,
          -- ["<c-a>"] = p4_add,
          -- ["<c-e>"] = p4_edit,
          -- ["<c-r>"] = p4_revert,
          -- ["<c-g>"] = p4_fstat,
          -- ["<C-t>"] = require("trouble.sources.telescope").open,
        },
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          -- ["<c-a>"] = p4_add,
          -- ["<c-e>"] = p4_edit,
          -- ["<c-r>"] = p4_revert,
          -- ["<c-g>"] = p4_fstat,
          -- ["<C-t>"] = require("trouble.sources.telescope").open,
        },
      },
      prompt_prefix = "🔍 ",
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      file_ignore_patterns = always_ignored,
      layout_config = {
        prompt_position = "top",
        horizontal = {
          mirror = true,
        },
        vertical = {
          mirror = true,
        },
        flex = {
          flip_columns = 110,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      file_browser = {
        theme = nil,
        hijack_netrw = false,
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup(opts)

    -- local p4_actions = require("p4.api.telescope.actions")
    --
    -- -- Open all or selected files for add.
    -- local p4_add = p4_actions.add
    --
    -- -- Open all or selected files for edit.
    -- local p4_edit = p4_actions.edit
    --
    -- -- Revert all or selected files that are opened for add/edit.
    -- local p4_revert = p4_actions.revert
    --
    -- -- Get file information.
    -- local p4_fstat = p4_actions.fstat

    require("telescope").load_extension("fzy_native")
    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("env")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("lazy")
    require("telescope").load_extension("p4")
    require("telescope").load_extension("frecency")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Workspace Files" })

    vim.keymap.set("n", "<leader>fa", function()
      builtin.find_files({
        -- file_ignore_patterns = bs.telescope.always_ignored,
        no_ignore = true,
        hidden = true,
      })
    end, { desc = "Workspace Files (All)" })

    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Find Word Under Cursor" })

    vim.keymap.set("n", "<leader>gw", builtin.live_grep, { desc = "Grep String" })

    vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Find Current Buffer" })

    vim.keymap.set("n", "<leader>hv", builtin.help_tags, { desc = "Plugin Help" })

    vim.keymap.set("n", "<leader>hm", builtin.man_pages, { desc = "Find Manual" })

    vim.keymap.set("n", "<leader>jb", builtin.builtin, { desc = "List Telescope Builtins" })

    vim.keymap.set("n", "<leader>tr", builtin.resume, { desc = "Telescope Resume" })

    vim.keymap.set("n", "<leader>m", builtin.keymaps, { desc = "List Keymaps" })

    vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "List Command History" })

    vim.keymap.set("n", "<leader>b", function()
      builtin.buffers({
        ignore_current_buffer = true,
        sort_mru = true,
      })
    end, { desc = "Buffers" })

    vim.keymap.set("n", "<leader>fd", function()
      builtin.find_files({
        cwd = "~/dotfiles",
      })
    end, { desc = "Search Dotfiles" })

    vim.keymap.set("n", "<leader>fh", function()
      builtin.find_files({
        cwd = "~",
      })
    end, { desc = "Search Home" })

    vim.keymap.set("n", "<leader>gv", function()
      builtin.live_grep({
        cwd = os.getenv("VIMRUNTIME") .. "/doc",
      })
    end, { desc = "Grim Vim Help" })

    vim.keymap.set("n", "<leader>ld", function()
      builtin.diagnostics({
        bufnr = 0,
      })
    end, { desc = "Buffer Diagnostics" })

    vim.keymap.set("n", "<leader>lad", builtin.diagnostics, { desc = "Project Diagnostics" })

    vim.keymap.set({ "n" }, "<leader>fb", ":Telescope file_browser<CR>", { desc = "File Browser" })
    vim.keymap.set({ "n" }, "<leader>nh", ":Telescope notify<CR>", { desc = "List Notifications" })
    vim.keymap.set({ "n" }, "<leader>te", ":Telescope env<CR>", { desc = "List Environment Variables" })
    vim.keymap.set({ "n" }, "<leader>tp", ":Telescope lazy<CR>", { desc = "Plugin Browser" })

    vim.keymap.set({ "n" }, "<leader>rw", ":Telescope fecency<CR>", { desc = "Telescope frecency" })
  end,
}
