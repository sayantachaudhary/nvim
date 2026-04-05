return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- auto_install = vim.fn.executable("tree-sitter") == 1,
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		require("nvim-treesitter").install({
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(event)
				pcall(vim.treesitter.start, event.buf)
			end,
		})

		vim.keymap.set({ "n", "x" }, "<C-space>", function()
			if vim.treesitter.get_parser(nil, nil, { error = false }) then
				require("vim.treesitter._select").select_parent(vim.v.count1)
			else
				vim.lsp.buf.selection_range(vim.v.count1)
			end
		end, { desc = "Select parent (outer) node" })

		vim.keymap.set({ "x" }, "<BS>", function()
			if vim.treesitter.get_parser(nil, nil, { error = false }) then
				require("vim.treesitter._select").select_child(vim.v.count1)
			else
				vim.lsp.buf.selection_range(-vim.v.count1)
			end
		end, { desc = "Select child (inner) node" })
	end,
}
