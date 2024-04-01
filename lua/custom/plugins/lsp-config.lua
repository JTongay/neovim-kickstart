--return {
-- LSP Configuration & Plugins
--'neovim/nvim-lspconfig',
--dependencies = {
-- Automatically install LSPs to stdpath for neovim
--{ 'williamboman/mason.nvim', opts = {} },
--{
--'williamboman/mason-lspconfig.nvim',
--opts = {
--ensure_installed = {
--"lua_ls",
-- "graphql",
-- "html",
-- "htmx",
-- "tsserver",
-- "ruby_ls",
--"gopls"
--}
--}
-- config = function ()
--   require('mason-lspconfig').setup({

-- })
-- end
--},

-- Useful status updates for LSP
-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
-- { 'j-hui/fidget.nvim',       opts = {} },

-- Additional lua configuration, makes nvim stuff amazing!
--'folke/neodev.nvim',
--}
--}

return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'lua_ls', 'graphql', 'html', 'htmx', 'gopls', 'solargraph' },
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      'fole/neodev.nvim'
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.graphql.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities
      })
      lspconfig.eslint.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
            workingDirectory = { mode = 'location' },
        },
        root_dir = lspconfig.util.find_git_ancestor,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  }
}
