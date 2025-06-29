return {
  "folke/trouble.nvim",
  opts = {},
  keys = {
    {
      "<leader>lt",
      "<Cmd>Trouble diagnostics toggle<CR>",
      desc = "Dianostics (Trouble)",
    },
    {
      "<leader>lT",
      "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>ls",
      "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
      desc = "LSP Definitions / references / ... (Trouble)",
   },
   {
      "<leader>lL",
      "<Cmd>Trouble loclist toggle<CR>",
      desc = "Location List (Trouble)",
   },
   {
      "<leader>lq",
      "<Cmd>Trouble qflist toggle<CR>",
      desc = "Quickfix List (Trouble)",
   },
  },
}
