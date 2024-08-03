-- TERMINAL
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.size = 23

-- TELESCOPE
lvim.builtin.telescope.defaults = {
  layout_config = {
    center = {
      width = 0.6,
      height = 0.2,
      -- prompt_position = "top",
      -- preview_cutoff = 50,
    },
    vertical = {
      height = 0.6,
      width = 0.7,
      prompt_position = "top",
    }
  },
  layout_strategy = 'vertical',
  -- prompt_prefix = " > ",
  file_ignore_patterns = {
    ".venv",
    "venv",
    ".git"
  },
}


-- lvim.builtin.telescope.defaults.prompt_prefix = " > "
-- lvim.builtin.telescope.extensions.fzf = nil

lvim.builtin.project.detection_methods = { "lsp" }
