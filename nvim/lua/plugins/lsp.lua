-- zsh as bash for diagnostics
vim.filetype.add({
  filename = {
    [".zsh"] = "sh",
    [".zshrc"] = "sh",
    [".zprofile"] = "sh",
    [".zshenv"] = "sh",
    [".zlogin"] = "sh",
    [".bashrc"] = "bash",
    [".bash_profile"] = "bash",
    [".bash_logout"] = "bash",
    [".bash_aliases"] = "bash",
  },
  extension = {
    zsh = "sh",
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
      opts.servers.bashls = {
        -- filetypes = { "sh", "bash" }, -- activate for sh and zsh
        filetypes = { "sh", "zsh", "bash" }, -- activate for sh and zsh
        -- settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command|.zsh)" } },
      }
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
    -- ft = { "zsh" },
    ft = { "sh", "zsh" },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "black",
        "shfmt",
      },
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      -- format = {
      --   timeout_ms = 3000,
      --   async = false, -- not recommended to change
      --   quiet = false, -- not recommended to change
      --   lsp_format = "fallback", -- not recommended to change
      -- },
      formatters_by_ft = {
        python = { "black" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        bash = { "shfmt" }, -- optional for bash files
      },
    },
  },
}
