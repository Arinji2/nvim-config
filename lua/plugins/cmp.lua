return {
  -- 1. Load NvChad's default Blink UI and settings
  { import = "nvchad.blink.lazyspec" },

  -- 2. Override blink.cmp to add our custom sorting logic
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.fuzzy = opts.fuzzy or {}

      -- Get the default sorts (usually 'score', 'sort_text', etc.)
      local default_sorts = opts.fuzzy.sorts or { "score", "sort_text" }

      -- Create a custom rule to boost local imports
      local boost_local_imports = function(a, b)
        -- Helper to safely extract the import path from the LSP item
        local function get_path(item)
          return item.detail
            or (item.labelDetails and item.labelDetails.detail)
            or (item.labelDetails and item.labelDetails.description)
            or ""
        end

        local path_a = get_path(a)
        local path_b = get_path(b)

        -- Check if the path starts with '.' (like ./ or ../) or '@/' (common Next.js alias)
        local is_local_a = path_a:match "^%." or path_a:match "^@/"
        local is_local_b = path_b:match "^%." or path_b:match "^@/"

        if is_local_a and not is_local_b then
          return true -- 'a' goes first
        elseif is_local_b and not is_local_a then
          return false -- 'b' goes first
        end

        -- If both are local or both are node_modules, return nil to fallback to normal sorting
        return nil
      end

      -- Inject our custom rule at the very front of the sorting list!
      opts.fuzzy.sorts = { boost_local_imports, unpack(default_sorts) }

      return opts
    end,
  },
}
