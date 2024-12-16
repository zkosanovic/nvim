require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- open nvim-tree when opening a directory
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

autocmd({ "VimEnter" }, { callback = open_nvim_tree })

autocmd("FileType", {
  pattern = "typescript",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

-- Leave snippet when changing mode, so it doesn't hijack the TAB key after
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
local function leave_snippet()
  if
    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

autocmd("ModeChanged", { callback = leave_snippet })
