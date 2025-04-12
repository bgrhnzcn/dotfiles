-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
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

