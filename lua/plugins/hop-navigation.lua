-- https://github.com/hadronized/hop.nvim

return {
  "hadronized/hop.nvim",
  config = function()
    local hop = require("hop")
    hop.setup()

    local directions = require('hop.hint').HintDirection

    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end,
    {remap=true})

    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end,
    {remap=true})

  end
}
