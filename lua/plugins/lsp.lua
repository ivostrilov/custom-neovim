# https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  config = function()
    local lsp_config = require('lspconfig')

    lsp_config.clangd.setup({ autostart = false })
    -- lspconfig.jdtls.setup {}
    -- lspconfig.pyright.setup {}

    -- Info commands
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { desc = "LSP go to type definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover info under cursor" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Diagnostic hover info" })

    -- Editing commands
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "LSP rename under cursor" })
    vim.keymap.set("n", "<space>rf", vim.lsp.buf.format, { desc = "LSP format buffer"})
  end,
}