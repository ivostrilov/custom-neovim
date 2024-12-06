-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  config = function()
    local enabled_servers = {
      bashls = false,
      pylsp = false,
      clangd = false,
    }

    local lsp_config = require('lspconfig')

    if enabled_servers.bashls then
      lsp_config.bashls.setup {
        settings = {
          bashIde = {
            shellcheckPath = "shellcheck",
          },
        },
      }
    end

    if enabled_servers.pylsp then
      lsp_config.pylsp.setup {
        cmd = { "poetry", "run", "pylsp" },
        settings = {
          pylsp = {
            plugins = {
              -- formatter
              black = { enabled = true, path = "poetry run pyflakes" },

              isort = { enabled = true }, -- sorting import

              -- static analysis
              pyflakes = { enabled = true, path = "poetry run pyflakes" },
              flake8 = { enabled = true },

              -- отключаем конфликтующие плагины
              pycodestyle = { enabled = false }
            }
          }
        }
      }
    end

    if enabled_servers.clangd then
      lsp_config.clangd.setup {}
    end

    -- Control commands
    vim.keymap.set("n", "<space>ls", ":LspStart<cr>", { desc = "LSP start" })
    vim.keymap.set("n", "<space>lS", ":LspStop<cr>", { desc = "LSP stop" })
    vim.keymap.set("n", "<space>lr", ":LspRestart<cr>", { desc = "LSP restart" })

    -- Info commands
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { desc = "LSP go to type definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover info under cursor" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Diagnostic hover info" })

    -- Editing commands
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "LSP rename under cursor" })
    vim.keymap.set("n", "<space>rf", function()
      vim.lsp.buf.format({ async = false })

      -- Выполняем isort только для Python-файлов
      local filetype = vim.bo.filetype
      if filetype == "python" and vim.fn.expand("%") ~= "" then
        vim.cmd(":w")  -- Сохраняем файл
        vim.cmd(":silent !poetry run isort --quiet %")
        vim.cmd(":edit!")  -- Перезагружаем буфер
      end
    end, { desc = "Format & sort imports" })
  end
}
