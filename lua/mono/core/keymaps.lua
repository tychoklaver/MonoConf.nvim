vim.g.mapleader = " "
local keymap = vim.keymap
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", {desc = "split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc = "make split equal size"})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "close current split"})

-- Increment/Decrement Int Values
keymap.set("n", "<leader>+", "<C-a>", {desc = "increment number"})
keymap.set("n", "<leader>-", "<C-x>", {desc = "decrement number"})

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

-- move selected text in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Add whitespace to selected text in visual mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
