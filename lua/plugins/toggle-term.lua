return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  config = function()
    local colors = dofile(vim.g.base46_cache .. "colors")

    -- Setup toggleterm
    require("toggleterm").setup {
      size = 5,
      shade_terminals = false,
      highlights = {
        NormalFloat = {
          guibg = colors.black,
        },
      },
    }
  end,
}
