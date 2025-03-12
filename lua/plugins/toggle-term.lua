return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<M-g>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Open ToggleTerm" }, -- Load on Alt+G
  },
  config = function()
    local colors = dofile(vim.g.base46_cache .. "colors")

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
