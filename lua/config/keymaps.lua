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

-- Git
vim.keymap.set("n", "<leader>gs", function()
  vim.cmd("Git")
end, { noremap = true, silent = true, desc = "Git status" })

vim.keymap.set("n", "<leader>gp", function()
  vim.cmd("Git push")
end, { noremap = true, silent = true, desc = "Git push" })

vim.keymap.set("n", "<leader>gl", function()
  vim.cmd("Gclog")
end, { noremap = true, silent = true, desc = "Git commit log" })
