require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

map("i", "jk", "<ESC>")

-- copilot
map("n", "<leader>cq", function()
  local id
  local running = false

  for _, s in ipairs(vim.lsp.get_clients { name = "copilot" }) do
    id = s.id
    running = true
  end

  if running then
    vim.lsp.stop_client(id)
  end
end, { desc = "kill copilot lsp" })
