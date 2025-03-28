vim.cmd 'colorscheme material'
require('material.functions').change_style("darker")

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Line Numbers
vim.opt.number = true
--vim.opt.relativenumber = true

-- Vertical column
vim.opt.colorcolumn = "80"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard
vim.keymap.set("n", "<space>y", '"*y', { desc = "Copy to clipboard" })
vim.keymap.set("v", "<space>y", '"*y', { desc = "Copy to clipboard" })

-- Shorter messages
-- vim.opt.shortmess:append("c")

-- Indent Settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Fillchars
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}

