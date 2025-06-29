local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
local sqlbq_home = os.getenv("HOME") .. "/dev/tree-sitter-sql-bigquery"

parser_config.sql_bigquery = {
  install_info = {
    url = sqlbq_home,
    files = { "src/parser.c", "src/scanner.c" },
    requires_generate_from_grammar = false,
  },
  filetype = "bigquery",
}

vim.filetype.add({ extension = { bql = "sql_bigquery" } })

vim.opt.rtp:append(sqlbq_home)
