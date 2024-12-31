return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-b>",
    }
  end,
}
