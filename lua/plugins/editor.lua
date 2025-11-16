
return {
  -- change some telescope options and a keymap to browse plugin files
  --{
  --  "nvim-telescope/telescope.nvim",
  --  dependencies = { "fcying/telescope-ctags-outline.nvim" },
  --  keys = {
  --    -- add a keymap to browse plugin files
  --    -- stylua: ignore
  --    {
  --      "<leader>B",
  --      "<cmd>Telescope buffers<cr>",
  --      desc = "Buffers",
  --    },
  --    {
  --      "<leader>e",
  --      "<cmd>Telescope file_browser<cr>",
  --      desc = "File browser",
  --    },
  --    {
  --      "<leader>F",
  --      "<cmd>Telescope find_files<cr>",
  --      desc = "Find Files",
  --    },
  --    {
  --      "<leader>G",
  --      "<cmd>Telescope live_grep<cr>",
  --      desc = "Grep",
  --    },
  --    -- Unbinding
  --    { "<leader>,", false },
  --    { "<leader>t", "<cmd>Telescope ctags_outline<cr>", desc = "Ctags Outline" },
  --  },
  --  opts = function()
  --    -- require ctags_outline extension
  --    require("telescope").load_extension("ctags_outline")
  --    require("telescope").load_extension("file_browser")

  --    local fb_actions = require("telescope").extensions.file_browser.actions

  --    return {
  --      extensions = {
  --        ctags_outline = {
  --          --ctags option
  --          ctags = { "ctags" },
  --          --ctags filetype option
  --          ft_opt = {
  --            -- vim = "--vim-kinds=fk",
  --            -- javascript = "--javascript-kinds=f",
  --            -- lua = "--lua-kinds=fk",
  --            -- python = "--python-kinds=fm --language-force=Python",
  --            -- typescript = "--typescript-kinds=f",
  --          },
  --        },
  --        file_browser = {
  --          theme = "dropdown",
  --          mappings = {
  --            ["i"] = {
  --              ["<C-t>"] = fb_actions.change_cwd,
  --              ["<C-r>"] = fb_actions.create,
  --            },
  --            ["n"] = {},
  --          },
  --        },
  --      },
  --    }
  --  end,
  --},
  --{
  --  "nvim-telescope/telescope-file-browser.nvim",
  --  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --},
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>B", "<cmd>FzfLua buffers<cr>", desc = "Switch buffers" },
      { "<leader>F", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>G", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      -- Unbinding
      { "<leader>,", false },
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      {
        "<leader>gb",
        "<cmd>Git blame<cr>",
        desc = "Git Blame",
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    enabled = false,
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   opts = {
  --     suggestion = { enabled = true },
  --   },
  -- },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  -- Pairs brackets, "autopairs"
  { "nvim-mini/mini.pairs", enabled = false },
  { "jack-michaud/ai-actions" },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ch",
        "<cmd>ChatGPT<cr>",
        desc = "Start ChatGPT",
      },
    },
    config = function()
      require("chatgpt").setup({
        actions_paths = {
          vim.fn.stdpath("config") .. "/lua/plugins/ai_actions.json",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
      "jack-michaud/ai-actions",
    },
  },

  {
    "lualine.nvim",
    opts = function()
      return {
        sections = {
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            "filename",
          },
        },
      }
    end,
  },
  {
    "savq/melange-nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("melange")

      -- Enable transparency
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    end,
  },
}
