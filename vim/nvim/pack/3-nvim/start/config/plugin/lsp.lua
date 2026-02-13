-----------------------------------------------------------
-- nvim native LSP configuration
-----------------------------------------------------------

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr }

    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)

    -- LSP main actions
    vim.keymap.set('n', ';;', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', ';l', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', ";'", vim.lsp.buf.references, opts)

    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f',  function() vim.lsp.buf.format({ async = true }) end, opts)

    -- Signature help in insert mode
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Document highlight (equivalent to g:lsp_document_highlight_enabled)
    if client.server_capabilities.documentHighlightProvider then
        local hl_group = vim.api.nvim_create_augroup('LspHighlight_' .. bufnr, {})
        vim.api.nvim_create_autocmd('CursorHold', {
            group = hl_group, buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = hl_group, buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- Native completion (Neovim >= 0.11)
    -- triggerCharacters come from the server; this hooks into omnifunc/popup
    if vim.lsp.completion then
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Inlay hints (Neovim >= 0.10)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    vim.opt_local.signcolumn = 'yes'

    -- Suppress LSP diagnostics entirely, ALE handles it
    --vim.diagnostic.config({
    --    virtual_text = false,
    --    signs = false,
    --    underline = false,
    --    update_in_insert = false,
    --})

    -- Show LSP diagnostics (replaces ALE)
    vim.diagnostic.config({
        virtual_text = { prefix = '>', spacing = 4 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    -- Navigate diagnostics
    vim.keymap.set('n', ',,', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '..', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

    -- Completion
    -- TODO: move out? replace with nvim-cmp?

    local cmp = require('cmp')
    cmp.setup({
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- priority 1
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'calc' },
      }, {
          { name = 'buffer' },    -- fallback
      }),
      mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      }),
    })


    --vim.opt.completeopt = { 'menuone', 'noinsert', 'popup' }

    ---- Accept completion with <CR>
    --vim.keymap.set('i', '<CR>', function()
    --    if vim.fn.pumvisible() == 1 then
    --        return '<C-y>'  -- accept selected item
    --    end
    --    return '<CR>'
    --end, { expr = true })

    ---- Force-trigger completion (replaces your <C-Space> asyncomplete mapping)
    --vim.keymap.set('i', '<C-Space>', vim.lsp.completion.trigger)

    -- Toggle LSP
    vim.keymap.set('n', '<F7>', function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients > 0 then
          -- Stop all clients for this buffer
          for _, client in ipairs(clients) do
              vim.lsp.stop_client(client.id)
          end
          print('LSP stopped')
      else
          -- Re-trigger FileType to restart LSP
          vim.cmd('edit')
          print('LSP restarting...')
      end
  end)


end

-----------------------------------------------------------
-- Server: clangd
-----------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp' },
  callback = function(ev)
      if vim.fn.executable('clangd') ~= 1 then return end
      vim.lsp.start({
          name = 'clangd',
          cmd = {
              'clangd',
              '--background-index',
              '--all-scopes-completion',
              '--completion-style=detailed',
              '--header-insertion=never',
          },
          root_dir = vim.fs.root(ev.buf, {
              'compile_commands.json',
              'compile_flags.txt',
              '.clangd',
              '.git',
          }),
          on_attach = on_attach,
      })
  end,
})

-----------------------------------------------------------
-- Server: pylsp
-----------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(ev)
      if vim.fn.executable('pylsp') ~= 1 then return end
      vim.lsp.start({
          name = 'pylsp',
          cmd = { 'pylsp' },
          root_dir = vim.fs.root(ev.buf, {
              'pyproject.toml',
              'setup.py',
              'setup.cfg',
              'requirements.txt',
              '.git',
          }),
          settings = {
              pylsp = {
                  plugins = {
                      pydocstyle = { enabled = false },
                  },
              },
          },
          on_attach = on_attach,
      })
  end,
})

-----------------------------------------------------------
-- Server: rust-analyzer
-----------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(ev)
      if vim.fn.executable('rust-analyzer') ~= 1 then return end
      vim.lsp.start({
          name = 'rust-analyzer',
          cmd = { 'rust-analyzer' },
          root_dir = vim.fs.root(ev.buf, { 'Cargo.toml', '.git' }),
          settings = {
              ['rust-analyzer'] = {
                  cargo = {
                      buildScripts = { enable = true },
                      features = 'all',
                  },
                  procMacro = { enable = true },
              },
          },
          on_attach = on_attach,
      })
  end,
})
