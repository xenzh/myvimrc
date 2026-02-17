-- All LSP, servers and completion configurations, exclusive for neovim.

-- Hover / signature / diagnostic float borders (Neovim 0.11+)
local hover_opts = { border = "single" }
local _hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function() _hover(hover_opts) end
local _sig = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function() _sig(hover_opts) end


-- LSP configuration
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

    -- Inlay hints (Neovim >= 0.10)
    --if client.server_capabilities.inlayHintProvider then
    --    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    --end
    vim.lsp.inlay_hint.enable(false)

    vim.opt_local.signcolumn = 'yes'

    -- Suppress LSP diagnostics entirely, rely on ALE
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
        float = { border = "rounded" },
    })

    -- Navigate diagnostics
    vim.keymap.set('n', ',,', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '..', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>d', function()
        vim.diagnostic.open_float({ scope = 'line', source = true })
    end)

    -- Completion via nvim-cmp
    local cmp = require('cmp')
    cmp.setup({
        sources = cmp.config.sources({
            {
                name = 'nvim_lsp',
                entry_filter = function(entry, ctx)
                    -- no LSP completions in comments
                    local context = require('cmp.config.context')
                    if context.in_treesitter_capture('comment')
                        or context.in_syntax_group('Comment') then
                        return false
                    end

                    -- remove snippets
                    return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
                end
            },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'calc' },
        }, {
            { name = 'buffer' }, -- fallback source, buffer words.
        }),
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        }),
        formatting = {
            -- add a menu column that identifiers the completion source.
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    buffer   = '[Buf]',
                    path     = '[Path]',
                    calc     = '[Calc]',
                    nvim_lsp_signature_help = '[Sig]',
                })[entry.source.name]
                return vim_item
            end,
        },
        window = {
            -- add borders to documentation float windows (to avoid blending with bg).
            documentation = {
                border = 'single',
                winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
            },
        },
        experimental = {
            ghost_text = true -- ghost text for the selected completion entry.
        }
    })

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
              '--clang-tidy',
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
                  check = {
                      command = 'clippy',
                  },
                  procMacro = { enable = true },
              },
          },
          on_attach = on_attach,
      })
  end,
})
