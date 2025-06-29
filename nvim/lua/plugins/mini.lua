return {
  "echasnovski/mini.nvim",
  config = function()
    -- Around/Inside text objects.
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nsidie [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings.
    --
    -- Examples:
    --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    --  - sd'   - [S]urround [D]elete [']quotes
    --  - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
  end,
}
