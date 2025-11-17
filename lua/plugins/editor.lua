return {
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
    opts = {
      {'ivy'},
    }
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
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          buffer = {
            opts = {
              -- or (recommended) filter to only "normal" buffers
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end
            }
          }
        }
      }
    }
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
          lualine_c = {
          },
          lualine_x = {
            "lsp_status",
          },
          lualine_y = {
          },
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
  { "stevearc/oil.nvim",
   ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
      default_file_explorer = true
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ---@class snacks.gitbrowse.Config
      gitbrowse = {
        what = "permalink"
      }
    },
    keys = {
      {
        "<leader>gB",
        function() require("common.jjgitbrowse").open(require("snacks").config.gitbrowse) end,
        desc = "Open on git remote"
      }
    }
  }
}
