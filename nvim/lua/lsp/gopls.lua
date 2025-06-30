return {
  cmd = { "gopls" },
  settings = {
    analyses = {
      unusedparams = true,
      unreachable = true,
      unusedvariable = true,
    },
    usePlaceholders = true,
    completionBudget = "200ms",
    staticcheck = true,
    gofumpt = true,
    semanticTokens = true,
  },
  capabilities = {
    textDocument = {
      semanticTokens = {
        dynamicRegistration = false,
        requests = {
          range = false,
          full = { delta = true },
        },
      },
    },
  },
}
