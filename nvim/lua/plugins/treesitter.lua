return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "asm",
        "awk",
        "bash",
        "beancount",
        "bibtex",
        "c",
        "cmake",
        "cpp",
        "csv",
        "cuda",
        "diff",
        "dockerfile",
        "dot",
        "gitignore",
        "git_config",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "hcl",
        "html",
        "javascript",
        "jinja",
        "jinja_inline",
        "json",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "query",
        "r",
        "regex",
        "sql",
        "terraform",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        disable = { "query" },
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
      callback = function()
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      end,
    })
  end,
}
