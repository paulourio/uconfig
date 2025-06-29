return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          async = true,
          lsp_format = "fallback",
        })
      end,
      mode = "",
      desc = "[F]ormat Buffer",
    }
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(buf)
      local disable = { sql_bigquery = true }
      return {
        timeout_ms = 1000,
        lsp_format = (disable[vim.bo[buf].filetype] and "never") or "fallback",
      }
    end,
  },
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "gofumpt", "goimports" },
    hcl = { "hcl" },
    javascript = { "prettier" },
    lua = { "stylua" },
    python = { "ruff_organize_imports" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    xml = { "xmlformatter" },
    yaml = { "yamlfix" },
  },
  formatters = {
    clang_format = {
      command = "clang-format",
    },
    ruff_organize_imports = {
      command = "ruff",
      args = {
        "check",
        "--force-exclude",
        "--select=I001",
        "--fix",
        "--exit-zero",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
      stdin = true,
    },
    terraform_fmt = {
      command = "terraform",
      args = { "fmt" },
    },
  },
}
