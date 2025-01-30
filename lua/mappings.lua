require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

map("i", "jk", "<ESC>")

-- ufo
map("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
