return {
  "3rd/image.nvim",
  event = "VeryLazy",
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        download_remote_images = true,
        clear_in_insert_mode = false,
        only_render_image_at_cursor = false,
      },
    },
    window_overlap_clear_enabled = true,
    max_height_window_percentage = 50,
  },
}
