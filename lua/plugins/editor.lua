local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
      -- Unbinding
      { "<leader>,", false },
      { "<leader>gs", false },
    },
  },
  {
    "tpope/vim-fugitive",
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.dart_format.with({
          extra_args = { "--line-length=120" },
        }),
        require("null-ls").builtins.formatting.nixfmt,
        require("null-ls").builtins.formatting.gofmt,
        require("null-ls").builtins.formatting.phpcbf,
        require("null-ls").builtins.formatting.rustfmt,
        require("null-ls").builtins.formatting.terraform_fmt,
      })
    end,
  },
}
