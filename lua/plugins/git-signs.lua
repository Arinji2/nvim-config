return {
  "lewis6991/gitsigns.nvim",
  config = function()
    -- GitSigns configuration
    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      numhl = true,
    }

    -- Set custom highlights
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00" }) -- Green for added lines
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffcc00" }) -- Yellow for changed lines
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#ff6600" }) -- Orange for changed + deleted
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000" }) -- Red for deleted lines
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ff3300" }) -- Dark red for top-deleted lines
  end,
}
