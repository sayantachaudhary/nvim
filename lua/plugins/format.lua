return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>cf", ":lua vim.lsp.buf.format()<CR>", desc = "Format" },
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.black,
			},
		})

		local mr = require("mason-registry")
		mr.refresh(function()
			for _, name in ipairs({ "prettier", "stylua", "shfmt", "shellcheck" }) do
				local p = mr.get_package(name)
				if not p:is_installed() then
					p:install()
				end
			end
		end)
	end,
}
