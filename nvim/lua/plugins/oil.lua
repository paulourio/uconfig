return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup({
      default_file_explorer = false,
    })

    -- Set the keymap for opening the oil explorer
    vim.keymap.set("n", "<leader>po", "<Cmd>Oil<CR>", { silent = true, noremap = true })
  end,
}
