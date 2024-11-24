return {
  "akinsho/toggleterm.nvim",
  lazy = false, -- Load immediately
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = nil

    local colors = dofile(vim.g.base46_cache .. "colors")
    -- Lazygit terminal toggle function
    function _G.toggle_lazygit()
      if not lazygit then
        lazygit = Terminal:new {
          cmd = "lazygit",
          hidden = true,
          direction = "float",
          close_on_exit = true,
          float_opts = {
            border = "rounded",
            width = vim.o.columns,
            height = math.floor(vim.o.lines * 0.95),
            winblend = 3,
          },
        }
      end

      if lazygit:is_open() then
        lazygit:close()
      else
        lazygit:open()
      end
    end

    -- General terminal toggle function
    local term = Terminal:new { hidden = true }
    function _G.toggle_terminal()
      term:toggle()
    end

    -- Setup toggleterm
    require("toggleterm").setup {
      size = 5,
      shade_terminals = false,
      highlights = {
        NormalFloat = {
          guibg = colors.black, -- Use a default background color; customize if needed
        },
      },
    }

    -- Keymaps for toggling terminals
    vim.keymap.set(
      { "n", "t" },
      "<A-g>",
      "<cmd>lua toggle_lazygit()<CR>",
      { silent = true, desc = "Toggle LazyGit terminal" }
    )
    vim.keymap.set(
      { "n", "t" },
      "<C-\\>",
      "<cmd>lua toggle_terminal()<CR>",
      { silent = true, desc = "Toggle terminal" }
    )
  end,
}
