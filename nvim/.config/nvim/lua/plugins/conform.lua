return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      format_on_save = {},
      formatters_by_ft = {
        ["lua"] = { "stylua" },
      },
    })
  end,
}
