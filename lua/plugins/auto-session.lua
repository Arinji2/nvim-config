return {
  "rmagatti/auto-session",
  lazy = false,
  ---@module "auto-session"
  opts = {
    suppressed_dirs = { "~/Projects", "~/Downloads" },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
