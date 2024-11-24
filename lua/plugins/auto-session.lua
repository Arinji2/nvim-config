return {
  "rmagatti/auto-session",
  lazy = false,
  ---@module "auto-session"
  opts = {
    suppressed_dirs = { "~/Projects", "~/Downloads" },
    auto_restore_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
