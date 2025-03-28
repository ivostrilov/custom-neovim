-- https://github.com/j-morano/buffer_manager.nvim

return {
  "j-morano/buffer_manager.nvim",
  config = function()
    require("buffer_manager").setup{}

    vim.keymap.set(
      "n",
      "<space>bb", ":lua require('buffer_manager.ui').toggle_quick_menu()<CR>",
      { desc = "List buffers" }
    )

    vim.keymap.set(
      "n",
      "<space>,", ":lua require('buffer_manager.ui').nav_prev()<CR>",
      { desc = "List buffers" }
    )

    vim.keymap.set(
      "n",
      "<space>.", ":lua require('buffer_manager.ui').nav_next()<CR>",
      { desc = "List buffers" }
    )
    end,
}
