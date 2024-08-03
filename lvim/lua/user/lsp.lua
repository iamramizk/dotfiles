-- LSP
lvim.format_on_save = true
lvim.lsp.installer.setup.automatic_servers_installation = true

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ruff_lsp" })
-- vim.list_extend(lvim.linters.automatic_configuration.skipped_servers, { "ruff" })
-- vim.list_extend(lvim.formatters.automatic_configuration.skipped_servers, { "ruff" })
--
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "ruff_lsp"
-- end, lvim.lsp.automatic_configuration.skipped_servers)


lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
  "markdown",
}

-- Pyright settings
local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "off",     -- off, basic, strict
        useLibraryCodeForTypes = true
      }
    }
  },
}
require("lvim.lsp.manager").setup("pyright", pyright_opts)


-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "shfmt",
    filetypes = { "sh", "bash", "zsh" }
  },
  {
    name = "ruff_format",
    filetypes = "python",
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { name = "flake8" },
  -- {
  --   name = "ruff_lsp",
  --   filetypes = "python",
  -- },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}
