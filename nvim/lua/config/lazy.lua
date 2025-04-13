-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- Imports my plugins.
	spec = { { import = "plugins" } },
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.keymap.set("n", "<C-f>", function()
	require("neo-tree.command").execute({ source = "filesystem", "focus" })
end, { desc = "Toggle Neo-tree (filesystem)" })

vim.keymap.set("n", "<C-s>", function()
	require("neo-tree.command").execute({ source = "document_symbols", "focus" })
end, { desc = "Toggle Neo-tree (document_symbols)" })

vim.keymap.set("n", "<C-g>", function()
	require("neo-tree.command").execute({ source = "git_status", "focus" })
end, { desc = "Toggle Neo-tree (git_status)" })

vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true, nowait = true })

vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Move directly end and start of line
vim.api.nvim_set_keymap('n', '<S-Right>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Left>', '^', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<S-Right>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Left>', '^', { noremap = true, silent = true })

vim.api.nvim_set_keymap('o', '<S-Right>', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', '<S-Left>', '^', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<S-Right>', '<Esc>$a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Left>', '<Esc>^i', { noremap = true, silent = true })

-- Adds new line after and before cursor
vim.api.nvim_set_keymap('n', 'O', [[:lua vim.fn.append(vim.fn.line(".") - 1, "")<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'o', [[:lua vim.fn.append(vim.fn.line("."), "")<CR>j]], { noremap = true, silent = true })


