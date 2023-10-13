local function prefer_bin_from_venv(executable_name)
  -- Return the path to the executable if $VIRTUAL_ENV is set and the binary exists somewhere beneath the $VIRTUAL_ENV path, otherwise get it from Mason
  if vim.env.VIRTUAL_ENV then
    local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/bin/" .. executable_name, true, true)
    local executable_path = table.concat(paths, ", ")
    if executable_path ~= "" then
      -- vim.api.nvim_echo(
      -- 	{ { "Using path for " .. executable_name .. ": " .. executable_path, "None" } },
      -- 	false,
      -- 	{}
      -- )
      return executable_path
    end
  end

  local mason_registry = require("mason-registry")
  local mason_path = mason_registry.get_package(executable_name):get_install_path() .. "/venv/bin/" .. executable_name
  -- vim.api.nvim_echo({ { "Using path for " .. executable_name .. ": " .. mason_path, "None" } }, false, {})
  return mason_path
end

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
    "nvimtools/none-ls.nvim",
    enabled = false,
    -- opts = function(_, opts)
    --   local nls = require("null-ls")
    --   opts.root_dir = opts.root_dir
    --     or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")

    --   vim.list_extend(opts.sources, {
    --     nls.builtins.formatting.black,
    --     nls.builtins.formatting.isort,
    --     nls.builtins.formatting.prettier,
    --     nls.builtins.formatting.dart_format.with({
    --       extra_args = { "--line-length=120" },
    --     }),
    --     nls.builtins.formatting.nixfmt,
    --     nls.builtins.formatting.gofmt,
    --     nls.builtins.formatting.phpcbf,
    --     nls.builtins.formatting.rustfmt,
    --     nls.builtins.formatting.terraform_fmt,
    --   })
    -- end,
  },
  {
    "stevearc/conform.nvim",
    -- https://github.com/stevearc/conform.nvim
    enabled = true,
    opts = function(_, opts)
      local formatters = require("conform.formatters")
      formatters.black.command = prefer_bin_from_venv("black")
      formatters.stylua.args =
        vim.list_extend({ "--indent-type", "Spaces", "--indent-width", "2" }, formatters.stylua.args)

      local formatters_by_ft = {
        -- this extends lazyvim's conform setup
        -- https://www.lazyvim.org/extras/formatting/conform
        lua = { "stylua" },
        sh = { "shfmt" },
        --go = { "gofumpt", "gci" }, -- goimports is not needed as gci is used
        --protobuf = { "buf" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
      }

      -- extend opts.formatters_by_ft
      -- NOTE: conform.nvim can use a sub-list to run only the first available formatter (see docs)
      for ft, formatters_ in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        vim.list_extend(opts.formatters_by_ft[ft], formatters_)
      end
    end,
  },

  {
    "mfussenegger/nvim-lint",
    -- https://github.com/mfussenegger/nvim-lint
    enabled = true,
    opts = function(_, opts)
      local linters = require("lint").linters
      linters.mypy.cmd = prefer_bin_from_venv("mypy")
      linters.sqlfluff.args = vim.list_extend({ "--dialect", "postgres" }, linters.sqlfluff.args)

      local linters_by_ft = {
        -- this extends lazyvim's nvim-lint setup
        -- https://www.lazyvim.org/extras/linting/nvim-lint
        protobuf = { "buf", "protolint" },
        python = { "pyright", "mypy" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        yaml = { "yamllint" },
      }

      -- extend opts.linters_by_ft
      for ft, linters_ in pairs(linters_by_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        vim.list_extend(opts.linters_by_ft[ft], linters_)
      end
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = true },
    },
  },
}