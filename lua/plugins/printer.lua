return {
  "rareitems/printer.nvim",
  config = function()
    require("printer").setup {
      keymap = "gp",
    }
  end,
}
