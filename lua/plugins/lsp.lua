-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  tag = "v1.7.0",
  config = function()
    local enabled_servers = {
      bashls = false,
      pylsp = false,
      clangd = false,
      jdtls = false
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
              black = { enabled = true, line_length = 80 },
              isort = { enabled = true, line_length = 80, profile = "black" },

              -- static analysis
              pyflakes = { enabled = true },
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

    if enabled_servers.jdtls then
      lsp_config.jdtls.setup({
        cmd = { 'jdtls.sh' },
        filetypes = { 'java' },
        root_dir = function(fname)
          return lsp_config.util.root_pattern(
          'pom.xml',
          'gradlew',
          '.git',
          'build.gradle'
          )(fname) or lspconfig.util.path.dirname(fname)
        end
      })
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
      if vim.bo.filetype == "python" then
        vim.cmd(":w")

        local filepath = vim.fn.shellescape(vim.fn.expand("%:p"))

        local black_cmd = string.format("black --line-length 79 --quiet %s", filepath)
        local isort_cmd = string.format("isort --line-length 79 --profile black --quiet %s", filepath)

        local function execute(cmd, name)
          local output = vim.fn.system(cmd)
          if vim.v.shell_error ~= 0 then
            vim.notify(string.format("%s failed: %s", name, output), vim.log.levels.ERROR)
            return false
          end
          return true
        end

        local black_success = execute(black_cmd, "Black")

        if not black_success then
          table.insert(notify_messages, "Black formatting failed")
          return
        end

        local isort_success = execute(isort_cmd, "Isort")

        if not isort_success then
          table.insert(notify_messages, "isort failed")
          return
        end

        vim.cmd(":e!")

      else
        vim.lsp.buf.format({ async = false })
      end
    end, { desc = "Format & sort imports" })

  end
}
