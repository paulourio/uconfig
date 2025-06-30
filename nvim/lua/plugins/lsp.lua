return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools.
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Notifications and LSP progress messages.
      { "j-hui/fidget.nvim",    opts = {} },

      -- LuaLS
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },

      -- BigQuery
      {
        "kitagry/bqls.nvim"
      },

      {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
          bind = true,
          handler_opts = {
            border = "rounded",
          },
        },
      },

      -- Completion engine.
      "hrsh7th/nvim-cmp",

      -- Snippets.
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- Function call to configure the current buffer when LSP attaches to it.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local telescope = require("telescope.builtin")

          -- Rename variable under the cursor.
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          -- Execute a code action.
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          -- Find references for the word under the cursor.
          map("grr", telescope.lsp_references, "[G]oto [R]eferences")
          -- Jump to the implementation of the word under the cursor.
          map("gri", telescope.lsp_implementations, "[G]oto [I]mplementation")
          -- Jump to the definition of the word under the cursor.
          map("grd", telescope.lsp_definitions, "[G]oto [D]efinition")
          -- Jump to the declaration of the word under the cursor.
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          -- Jump to the type of the word under the cursor.
          map("grt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")
          -- Fuzzy find all the symbols in the current buffer.
          map("gD", telescope.lsp_document_symbols, "Open [D]ocument Symbols")
          -- Fuzzy find all the symbols in the current workspace.
          map("gW", telescope.lsp_dynamic_workspace_symbols, "Open [W]orkspace Symbols")

          -- Show help information for current symbol.
          map("<leader>ld", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, "Show symbol help")

          -- Highlight references of the word under the cursor when cursor
          -- rests for a little while.
          --   More information on `:help CursorHold`.
          if client:supports_method("textDocument/documentHighlight", event.buf) then
            local hi_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = hi_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = hi_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(detach_event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "lsp-highlight",
                  buffer = detach_event.buf,
                })
              end,
            })
          end

          -- Keymap to toggle inlay hints in the code.
          if client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Diagnostic configuration.
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          current_line = true,
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_enablue = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.bqls.setup({
        capabilities = capabilities,
        filetypes = { "sql_bigquery" },
        settings = {
          project_id = os.getenv("GCP_PROJECT"),
          location = os.getenv("GCP_BQ_LOCATION"),
        }
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- vim.lsp.enable("ty")
      -- vim.lsp.enable("pyright")
      -- vim.lsp.enable("gopls")
    end,
  },
}
