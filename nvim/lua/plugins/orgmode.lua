return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      local home = os.getenv("HOME") .. "/work"
      require("orgmode").setup({
        org_agenda_files = home .. "/org/**/*.org",
        org_default_notes_file = home .. "/journal/chores.org",
        org_todo_keywords = { "TODO", "IN-PROGRESS", "|", "DONE", "CANCELED", "POSTPONED" },
        org_capture_templates = {
          t = {
            description = "Chore",
            template = "* TODO %?\n  SCHEDULED: <%<%Y-%m-% %a>>\n",
            target = home .. "/journal/chores.org",
          },
          i = {
            description = "Incident",
            template = "* TODO %?\n  SCHEDULED: <%<%Y-%m-% %a>>\n",
            target = home .. "/journal/incidents.org",
          },
          a = {
            description = "Analysis",
            template = "* TODO %?\n  SCHEDULED: <%<%Y-%m-% %a>>\n",
            target = home .. "/journal/analysis.org",
          },
          j = {
            description = "Journal entry",
            template = "* TODO %?\n  SCHEDULED: <%<%Y-%m-% %a>>\n",
            target = home .. "/journal/journal.org",
          },
        },
      })
    end,
  },
  {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("orgmode")

      vim.keymap.set("n", "<leader>or", telescope.extensions.orgmode.refile_heading)
      vim.keymap.set("n", "<leader>os", telescope.extensions.orgmode.search_headings)
      vim.keymap.set("n", "<leader>oi", telescope.extensions.orgmode.insert_link)
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup {
        concealcursor = false,
        symbols = {
          list = "•",
          headlines = { "◉", "○", "✸", "✿" },
          checkboxes = {
            half = { "", "@org.checkbox.halfchecked" },
            done = { "✓", "@org.keyword.done" },
            todo = { "˟", "@org.keyword.todo" },
          },
        }
      }
    end
  }
}
