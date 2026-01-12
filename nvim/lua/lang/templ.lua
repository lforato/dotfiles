vim.lsp.config("templ", {
  cmd = { "templ", "lsp" },
  filetypes = { "templ" },
  root_markers = { "go.mod", "go.work", ".git" },
})

vim.lsp.enable("templ")
