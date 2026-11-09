require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

map("i", "jk", "<ESC>")

-- Go struct filling
map("n", "<leader>gf", function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return action.kind == "refactor.rewrite.fillStruct" and string.match(action.title, "Fill")
    end,
    apply = true,
  }
end, { desc = "Go fill struct" })
