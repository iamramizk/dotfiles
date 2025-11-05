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
      opts.diagnostics = { virtual_text = false }
      opts.inlay_hints = { enabled = false }
      opts.servers = opts.servers or {}
      opts.servers.cssls = {}
      opts.servers.ruff = {}
      -- opts.servers.ruff = {
      --   mason = false,
      --   enabled = false,
      -- }
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
    "mason-org/mason.nvim",
    -- "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        -- "black",
        "ruff",
        "shfmt",
        "html-lsp",
        "css-lsp",
      },
      ui = {
        border = "rounded",
      },
      -- PATH = "append",
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      formatters_by_ft = {
        -- python = { "ruff" },
        -- python = { "black" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        bash = { "shfmt" }, -- optional for bash files
      },
      -- default_format_opts = {
      --   timeout_ms = 3000,
      --   async = true, -- enable async formatting, recommended
      --   quiet = false,
      --   lsp_format = "fallback", -- fallback to LSP formatting if CLI formatter fails
      -- },
    },
  },
}
