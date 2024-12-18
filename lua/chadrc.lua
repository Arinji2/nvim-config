---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  hl_override = { IblChar = { fg = "#565b5d" }, IblScopeChar = { fg = "#7a8285" } },
}

M.ui = {
  lsp_semantic_tokens = true,
  cmp = {
    icons_left = true,
    format_colors = {
      tailwind = true,
    },
  },
  statusline = {
    theme = "default",
    separator_style = "arrow",
    modules = {
      file = function()
        -- relative file path rather than just file name
        local icon = "󰈚 "
        local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        local relpath = vim.fn.fnamemodify(path, ":.")
        local name = (relpath == "" and "Empty ") or relpath
        if name ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end
          name = " " .. name .. " "
        end
        return "%#StText# " .. icon .. name
      end,
      git = function()
        return ""
      end,
      cursor = function()
        return ""
      end,
    },
  },
}
return M
