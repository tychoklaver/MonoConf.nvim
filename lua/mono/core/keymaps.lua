vim.g.mapleader = " "
local keymap = vim.keymap
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", {desc = "split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc = "make split equal size"})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "close current split"})

--Tmux keybinds
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

keymap.set("n", "C-k", ":wincmd k<CR>")
keymap.set("n", "C-j", ":wincmd j<CR>")
keymap.set("n", "C-h", ":wincmd h<CR>")
keymap.set("n", "C-l", ":wincmd l<CR>")

keymap.set("n", "<leader>ee", "<cmd>Oil --float<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
