return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "cmake", "bashls"},
				handlers = {
					function(server_name)
						server_name.setup({ capabilities = capabilities })
					end
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.keymap.set('n', '<C-i>', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
			vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})

			local max_width = math.max(math.floor(vim.o.columns * 0.7), 100)
			local max_height = math.max(math.floor(vim.o.lines * 0.3), 30)

			-- NOTE: the hover handler returns the bufnr,winnr so can be used for mappings
			vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			  vim.lsp.handlers.hover,
			  { boarder = 'rounded', max_width = max_width, max_height = max_height }
			)

			vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			  border = 'rounded',
			  max_width = max_width,
			  max_height = max_height,
			})
		end
	}
}
