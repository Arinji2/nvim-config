---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers" },
  },
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
        -- relative file path limited to 5 levels
        local icon = "󰈚 "
        local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        local relpath = vim.fn.fnamemodify(path, ":.")

        -- Limit the path depth to 5 levels
        local parts = vim.split(relpath, "/")
        if #parts > 4 then
          relpath = table.concat(vim.list_slice(parts, #parts - 3, #parts), "/")
        end

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
    },
  },
}
return M
