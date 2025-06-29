return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- In a corporate environment, you might need to set a proxy for
    -- GitHub Copilot and disable strict SSL verification.
    -- vim.g.copilot_proxy_strict_ssl = false

    vim.keymap.set("i", "<C-/>", "<Plug>(copilot-accept)", { silent = true, noremap = true })
    -- Set the keymap for cycling through Copilot suggestions
    vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { silent = true, noremap = true })
    vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true, noremap = true })
  end,
}
