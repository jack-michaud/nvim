return {
  {
    "nvim-lspconfig",
    opts = function(opts)
      local ret = {
        setup = {
          html = {
            enabled = true,
          },
        },
      }
      return ret
    end,
  },
}



