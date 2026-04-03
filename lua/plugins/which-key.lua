return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,
		filter = function(mapping)
			return mapping.desc and mapping.desc ~= ""
		end,
		triggers = { { "<leader>", mode = "nxso" } },
		plugins = {
			marks = false,
			registers = false,
		},
		icons = {
			separator = "",
			group = "›",
			rules = false,
		},
		show_help = false,
		show_keys = false,
    -- stylua: ignore
    spec = {
      { "<leader>q",  ":q!<CR>",                              desc = "Quit" },
      { "<leader>x",  function() Snacks.bufdelete() end,      desc = "Delete Buffer" },
      { "<leader>,",  function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>g",  group = "git",                          mode = { "n", "x" } },
      { "<leader>s",  group = "search",                       mode = { "n", "x" } },

      { "<leader>c",  group = "code",                         mode = { "n", "x" } },
      { "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>",   desc = "Code Action" },
      { "<leader>cr", ":lua vim.lsp.buf.rename()<CR>",        desc = "Rename" },
      { "<leader>cd", ":lua vim.diagnostic.open_float()<CR>", desc = "Line Diagnostic" },
      { "<leader>cl", ":lua vim.diagnostic.setloclist()<CR>", desc = "Location List" },
      { "<leader>cq", ":lua vim.diagnostic.setqflist()<CR>",  desc = "Quickfix List" },

      { "<leader>u",  group = "ui", },
      { "<leader>us", ":set spell!<CR>",                      desc = "Toggle Spell" },
      { "<leader>uw", ":set wrap!<CR>",                       desc = "Toggle Wrap" },
    },
	},
}
