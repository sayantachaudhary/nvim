return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
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

		local function treesitter_try_attach(buf, language)
			if not vim.treesitter.language.add(language) then
				return
			end
			vim.treesitter.start(buf, language)
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end

		-- Auto install treesitter parsers
		local available_parsers = require("nvim-treesitter").get_available()
		local installed_parsers = require("nvim-treesitter").get_installed("parsers")

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match
				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end

				if vim.tbl_contains(installed_parsers, language) then
					treesitter_try_attach(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					require("nvim-treesitter").install(language):await(function()
						treesitter_try_attach(buf, language)
					end)
				else
					treesitter_try_attach(buf, language)
				end
			end,
		})
	end,
}
