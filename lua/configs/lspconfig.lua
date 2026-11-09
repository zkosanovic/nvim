-- NvChad defaults: diagnostics, LSP keymaps (via LspAttach), shared
-- capabilities for every server (vim.lsp.config "*"), and lua_ls
require("nvchad.configs.lspconfig").defaults()

-- Tell the Svelte server when JS/TS files change so cross-file types stay fresh
local svelte_group = vim.api.nvim_create_augroup("SvelteTsJsChanges", { clear = true })

vim.lsp.config("svelte", {
  filetypes = { "svelte" },
  on_attach = function(client)
    vim.api.nvim_clear_autocmds { group = svelte_group }
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = svelte_group,
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        client:notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.match) })
      end,
    })
  end,
})

vim.lsp.enable {
  "html",
  "cssls",
  "jsonls",
  "tailwindcss",
  "eslint",
  "ts_ls",
  "svelte",
  "rust_analyzer",
  "gopls",
  "golangci_lint_ls",
}
