return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<C-q>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
    }
  end,
}
