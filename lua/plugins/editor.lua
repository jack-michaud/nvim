local function prefer_bin_from_venv(executable_name)
  return "python"

  ---- Return the path to the executable if $VIRTUAL_ENV is set and the binary exists somewhere beneath the $VIRTUAL_ENV path, otherwise get it from Mason
  --if vim.env.VIRTUAL_ENV then
  --  local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/bin/" .. executable_name, true, true)
  --  local executable_path = table.concat(paths, ", ")
  --  if executable_path ~= "" then
  --    --vim.api.nvim_echo({ { "Using path for " .. executable_name .. ": " .. executable_path, "None" } }, false, {})
  --    return executable_path
  --  end
  --end

  ---- find poetry.lock file in current directory or parent directories
  --local poetry_lock = vim.fn.findfile("poetry.lock", ".;")
  --if poetry_lock ~= "" then
  --  -- use `poetry env info -p -C <path of folder containing poetry.lock>` to get the virtualenv path
  --  local poetry_env_path =
  --    vim.fn.systemlist("poetry env list --full-path -C " .. vim.fn.fnamemodify(poetry_lock, ":h"))

  --  if #poetry_env_path > 0 then
  --    local candidate_paths = {}
  --    for _, env_path in ipairs(poetry_env_path) do
  --      if env_path ~= "" then
  --        if string.sub(env_path, 0, 1) == "/" then
  --          table.insert(candidate_paths, 0, env_path)
  --        end
  --      end
  --    end
  --    local selected_poetry_env_path = candidate_paths[0]
  --    if #poetry_env_path > 1 then
  --      for _, env_path in ipairs(candidate_paths) do
  --        if string.find(env_path, "Activated") then
  --          print("Multiple virtualenvs found, using Activated " .. env_path)
  --          -- Must strip the word "(Activated)" from the string

  --          selected_poetry_env_path = string.gsub(env_path, " %(Activated%)", "")
  --          selected_poetry_env_path = vim.fn.trim(selected_poetry_env_path)
  --          break
  --        end
  --      end
  --    end
  --    local venv_path_to_python = selected_poetry_env_path .. "/bin/" .. executable_name
  --    if vim.fn.filereadable(venv_path_to_python) == 1 then
  --      print("Using path for " .. executable_name .. ": " .. venv_path_to_python)
  --      return venv_path_to_python
  --    end
  --  end
  --end

  --local mason_registry = require("mason-registry")
  --if mason_registry.has_package(executable_name) == false then
  --  return executable_name
  --end
  --local mason_path = mason_registry.get_package(executable_name):get_install_path() .. "/venv/bin/" .. executable_name
  ---- vim.api.nvim_echo({ { "Using path for " .. executable_name .. ": " .. mason_path, "None" } }, false, {})
  --return mason_path
end

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
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return prefer_bin_from_venv("python")
          end,
        },
      }
    end,
  },
  -- Pairs brackets, "autopairs"
  { "nvim-mini/mini.pairs", enabled = false },
  {
    -- lsp config
    "nvim-lspconfig",
    opts = function(opts)
      local pythonPath = prefer_bin_from_venv("python")
      local ret = {
        setup = {
          -- pyright = {
          --   enabled = true,
          --   settings = {
          --     python = {
          --       pythonPath = pythonPath,
          --       analysis = { diagnosticMode = "off", typeCheckingMode = "off" },
          --     },
          --   },
          -- },
          ruff_lsp = {
            enabled = true,
          },
        },
      }
      return ret
    end,
  },
  {
    "mfussenegger/nvim-lint",
    enabled = true,
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        python = { "mypy" },
      },
    },
    init = function()
      local mypy_config = require("lint").linters.mypy

      mypy_config.append_fname = false
      mypy_config.cmd = "poetry"
      mypy_config.args = {
        "run",
        "--",
        "dmypy",
        "run",
        "--",
        -- https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/mypy.lua
        "--show-column-numbers",
        "--show-error-end",
        "--hide-error-context",
        "--no-color-output",
        "--no-error-summary",
        "--no-pretty",
        "--use-fine-grained-cache",
        ".",
      }
    end,
  },
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
