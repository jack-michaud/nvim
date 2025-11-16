return {
  {
    -- lsp config
    "nvim-lspconfig",
    opts = function(opts)
      local ret = {
        setup = {
          lua_ls = {
            enabled = true,
          },
        },
      }
      return ret
    end,
  },
}


