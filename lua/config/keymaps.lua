-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Always include a "desc" in the lua map with a short description of the keymap

-- Hover
vim.keymap.set(
  "n",
  "<leader>h",
  "<cmd>lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "LSP Hover" }
)

-- Go to definition
vim.keymap.set(
  "n",
  "<leader>.",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true, desc = "LSP Go to definition" }
)

-- Find references
vim.keymap.set(
  "n",
  "<leader>,",
  "<cmd>lua vim.lsp.buf.references()<CR>",
  { noremap = true, silent = true, desc = "LSP Find references" }
)

-- Move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
