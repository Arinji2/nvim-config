return {
  "andweeb/presence.nvim",
  cmd = { "PresenceStart", "PresenceStop", "PresenceReload" },
  config = function()
    require("presence"):setup {}
  end,
}
