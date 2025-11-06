vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
      quotePreference = "auto",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
      format = {
        enable = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
      format = {
        enable = true,
      },
    },
  },
  handlers = {
    -- Handle rename request for certain code actions like extracting functions/types
    ["_typescript.rename"] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ["end"] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
})

-- Custom on_attach for ts_ls specific commands
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ts_ls_attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name ~= "ts_ls" then
      return
    end

    local bufnr = args.buf

    -- Create command for source actions (organize imports, remove unused, etc.)
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, "source.")
      end, client.server_capabilities.codeActionProvider.codeActionKinds or {})

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, { desc = "TypeScript source actions (organize imports, etc.)" })

    -- Add keymap for organize imports
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.organizeImports" },
        },
        apply = true,
      })
    end, { buffer = bufnr, desc = "Organize imports" })

    -- Add keymap for remove unused imports
    vim.keymap.set("n", "<leader>ru", function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.removeUnused" },
        },
        apply = true,
      })
    end, { buffer = bufnr, desc = "Remove unused imports" })
  end,
})

vim.lsp.enable("ts_ls")
