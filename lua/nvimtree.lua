require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})