utils = require("common.utils")

return {
  {
    -- lsp config
    "nvim-lspconfig",
    opts = function(opts)
      local pythonPath = utils.prefer_bin_from_venv("python")
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
}

