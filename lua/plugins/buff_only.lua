-- https://github.com/vim-scripts/BufOnly.vim

return {
  "vim-scripts/BufOnly.vim",
  config = function()
    vim.keymap.set(
      "n",
      "<space>bo", ":BufOnly<CR>",
      { desc = "List buffers" }
    )
  end
}
