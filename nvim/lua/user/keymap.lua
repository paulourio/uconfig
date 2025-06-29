vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Scroll window keeping the cursor in the middle.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Repeat latest search keeping the cursor in the middle.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste and delete without yanking.
vim.keymap.set({ "n", "x" }, "<leader>P", [["0p]], { desc = "paste from yank register" })
vim.keymap.set({"n", "v"}, "<leader>D", [["_d]], { desc = "delete without yanking"})

-- Yank to system's clipboard.
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Clear highlights.
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- Exit terminal.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


