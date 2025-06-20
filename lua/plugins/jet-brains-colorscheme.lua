-- https://github.com/nickkadutskyi/jb.nvim?tab=readme-ov-file

return {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd("colorscheme jb")
    end,
}
