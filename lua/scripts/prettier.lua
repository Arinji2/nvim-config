local M = {}

M.format_with_tailwind = function()
  local filepath = vim.fn.expand "%:p"
  local temp_dir = vim.fn.expand "~/.temp-prettier"

  -- Create the temp directory if it doesn't exist
  if vim.fn.isdirectory(temp_dir) == 0 then
    vim.fn.mkdir(temp_dir, "p")
    vim.fn.system("cd " .. temp_dir .. " && pnpm add prettier prettier-plugin-tailwindcss")
  end

  -- Format the file
  local cmd =
    string.format("cd %s && pnpm prettier --plugin prettier-plugin-tailwindcss --write %s", temp_dir, filepath)
  vim.fn.system(cmd)

  -- Reload the file in Neovim
  vim.cmd "edit!"
end

vim.api.nvim_create_user_command("TailwindFormat", M.format_with_tailwind, {})

return M
