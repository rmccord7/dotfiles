return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "asm",
        "bash",
        "c",
        "cmake",
        "cpp",
        "editorconfig",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "norg",
        "python",
        "regex",
        "rust",
        "ssh_config",
        "t32",
        "tmux",
        "toml",
        "udev",
        "vhdl",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      sync_install = true,
      highlight = require("rm.plugins.treesitter.highlight.config"),
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
      indent = {
        enable = false,
      },
      textobjects = require("rm.plugins.treesitter.textobjects.config"),
    },
    config = function(_, opts)
      -- Prefer clang for compiling TS
      require("nvim-treesitter.install").compilers = { "clang", "cc" }

      require("nvim-treesitter.configs").setup(opts)

      vim.keymap.set(
        { "n" },
        "]m",
        [[:TSTextobjectGotoNextStart @function.outer<CR>zz]],
        { desc = "Go to next function start" }
      )
      vim.keymap.set(
        { "n" },
        "]M",
        [[:TSTextobjectGotoNextEnd @function.outer<CR>zz]],
        { desc = "Go to next function end" }
      )
      vim.keymap.set(
        { "n" },
        "[m",
        [[:TSTextobjectGotoPreviousStart @function.outer<CR>zz]],
        { desc = "Go to previous function start" }
      )
      vim.keymap.set(
        { "n" },
        "[M",
        [[:TSTextobjectGotoPreviousEnd @function.outer<CR>zz]],
        { desc = "Go to previous function end" }
      )
    end,
  },

  require("rm.plugins.treesitter.context"),
  require("rm.plugins.treesitter.textobjects"),
  require("rm.plugins.treesitter.rainbow-delimiters"),
}
