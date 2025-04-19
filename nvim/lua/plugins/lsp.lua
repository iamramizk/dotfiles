vim.filetype.add({
  extension = {
    zsh = "sh",
  },
  filename = {
    [".zshrc"] = "sh",
    [".zprofile"] = "sh",
    [".zshenv"] = "sh",
  },
})

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = {
      virtual_text = false,
    }
    opts.servers = opts.servers or {}
    opts.servers.cssls = {}
    opts.servers.bashls = {}
  end,
}
