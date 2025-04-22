-- zsh as bash for diagnostics
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
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = {
        virtual_text = false,
      }
      opts.servers = opts.servers or {}
      opts.servers.cssls = {}
      opts.servers.ruff = {
        mason = false,
        enabled = false,
      }
      -- opts.servers.pyright = {}
      -- opts.servers.bashls = {
      --   filetypes = { "sh", "zsh" }, -- activate for sh and zsh
      --   settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command|.zsh)" } },
      -- }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },
  {
    "pablos123/shellcheck.nvim",
    config = function()
      require("shellcheck-nvim").setup({
        shellcheck_options = { "-x", "--enable=all" },
      })
    end,
    ft = { "sh", "zsh" },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
      },
      ui = {
        border = "rounded",
      },
    },
  },
}
