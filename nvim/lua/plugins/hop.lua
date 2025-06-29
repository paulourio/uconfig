return {
  "hadronized/hop.nvim",
  branch = "v2",
  config = function()
    require("hop").setup({
      keys = "etovxqpdygfblzhckisuran",
    })

    local hop = require("hop")
    local dirs = require("hop.hint").HintDirection

    vim.keymap.set("n", "<leader>f", function()
      hop.hint_char1({
        direction = dirs.AFTER_CURSOR,
        current_line_only = true,
      })
    end, { remap = true })

    vim.keymap.set("n", "<leader>F", function()
      hop.hint_char1({
        direction = dirs.BEFORE_CURSOR,
        current_line_only = true,

      })
    end, { remap = true })

    vim.keymap.set("n", "<leader>t", function()
      hop.hint_char1({
        direction = dirs.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      })
    end, { remap = true })

    vim.keymap.set("n", "<leader>T", function()
      hop.hint_char1({
        direction = dirs.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1,
      })
    end, { remap = true })

    vim.keymap.set("n", "<leader>h", function()
      hop.hint_words()
    end)
  end,
}
