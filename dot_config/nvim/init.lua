-- Font settings
vim.g.have_nerd_font = true
vim.o.guifont = "Hack Nerd Font,Noto Color Emoji:h12"

-- Remember previous window size and use for next session
vim.g.neovide_remember_window_size = true

-- Neovide-only configuration
if vim.g.neovide then
  -- Enable save, copy, paste, and close via cmd-S, cmd-C, cmd-P, and cmd-W
  local function save() vim.cmd.write() end
  local function copy() vim.cmd([[normal! "+y]]) end
  local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end

  vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
  vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-w>", ":q<CR>", { silent = true, desc = "Close" })
end

-- Source Vimscript-based configuration
local nvimrc = vim.fn.stdpath("config") .. "/neo.vim"
vim.cmd.source(nvimrc)
