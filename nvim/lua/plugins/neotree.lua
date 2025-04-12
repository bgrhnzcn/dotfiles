return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"git_status",
				"document_symbols",
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = " Files" },
					{ source = "git_status", display_name = " Git" },
					{ source = "document_symbols", display_name = " Symbols" },
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
				window = {
					mappings = {
						["<C-f>"] = "noop",
						["<C-s>"] = "noop",
						["<C-g>"] = "noop",
					},
				},
			},
			git_status = {
				window = {
					mappings = {
						["gA"] = "git_add_all",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["<C-f>"] = "noop",
						["<C-s>"] = "noop",
						["<C-g>"] = "noop",
					},
				},
			},
			document_symbols = {
				window = {
					follow_cursor = true,
					auto_expand_depth = 2,
					mappings = {
						["<cr>"] = "toggle_node",
						["<Tab>"] = "toggle_node",
						["g"] = "open",
						["p"] = "toggle_preview",
						["<C-f>"] = "noop",
						["<C-s>"] = "noop",
						["<C-g>"] = "noop",
					},
				},
			},
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			close_if_last_window = true,
			popup_border_style = "rounded",
		})
	end,
}
