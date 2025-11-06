return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local opts = { prefix = "<leader>", noremap = true, silent = true }
    local wk = require("which-key")

    wk.setup({
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      filter = function(_) -- exclude mappings that are not added
        return true
      end,

      win = {
        no_overlap = true,
        border = "single",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
    })

    wk.add({
      { "<leader>.",     desc = "Next Buffer",               remap = false },
      { "<leader>,",     desc = "Previous Buffer",           remap = false },
      { "<leader>/",     desc = "Toggle comment",            remap = false },
      { "<leader>w",     desc = "Close buffer",              remap = false },
      { "<leader><C-q>", desc = "Visual-Block mode",         remap = false },
      { "<leader><C-w>", desc = "Window commands",           remap = false },
      { "<leader>c",     group = "Code",                     remap = false },
      { "<leader>ca",    desc = "Code Action",               remap = false },
      { "<leader>cf",    desc = "Code Floating Diagnostics", remap = false },
      { "<leader>ch",    desc = "Code Signature Help",       remap = false },
      { "<leader>cr",    desc = "Code Rename",               remap = false },
      { "<leader>e",     desc = "File Tree",                 remap = false },
      { "<leader>f",     group = "File",                     remap = false },
      { "<leader>fw",    desc = "Find in files",             remap = false },
      { "<leader>ff",    desc = "Search file",               remap = false },
      { "<leader>fg",    desc = "Find Git File",             remap = false },
      { "<leader>fm",    desc = "Format File",               remap = false },
      { "<leader>fr",    desc = "Previous Search",           remap = false },
      { "<leader>fs",    desc = "Save File",                 remap = false },
      { "<leader>g",     group = "Go to",                    remap = false },
      { "<leader>gd",    desc = "Go to Definition",          remap = false },
      { "<leader>gr",    desc = "Go to References",          remap = false },
      { "<leader>t",     group = "Toggle",                   remap = false },
      { "<leader>tb",    desc = "Toggle Git Blame",          remap = false },
      { "<leader>tr",    desc = "Toggle Refactor",           remap = false },
      { "<leader>tt",    desc = "Toggle Trouble",            remap = false },
      { "<leader>x",     desc = "Close Buffer",              remap = false },
    }, opts)
  end,
}
