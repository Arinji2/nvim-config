return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = true,
  keys = {
    { "<C-b>", mode = { "n", "x" }, desc = "Activate Visual Multi" }, -- Load on keypress
  },
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-b>",
    }
  end,
}
