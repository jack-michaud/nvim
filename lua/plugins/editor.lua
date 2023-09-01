return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>B",
        "<cmd>Telescope buffers<cr>",
        desc = "Buffers",
      },
      {
        "<leader>F",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files",
      },
      {
        "<leader>G",
        "<cmd>Telescope live_grep<cr>",
        desc = "Grep",
      },
      { "<leader>,", false },
    },
  },
  -- Change the default folke/which-key.nvim keymap
  -- to exclude the <leader>b prefix
  {
    "tpope/vim-fugitive",
  },
}
