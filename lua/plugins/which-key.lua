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
      { "<leader>q",  ":q!<cr>",                                            desc = "Quit" },
      { "<leader>x",  function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },
      { "<leader>,",  function() Snacks.picker.buffers() end,               desc = "Buffers" },
      { "<leader>g",  group = "git",                                        mode = { "n", "x" } },

      { "<leader>c",  group = "code",                                       mode = { "n", "x" } },
      { "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>",                 desc = "Code Action" },
      { "<leader>cr", ":lua vim.lsp.buf.rename()<cr>",                      desc = "Rename" },
      { "<leader>cd", ":lua vim.diagnostic.open_float()<cr>",               desc = "Line Diagnostic" },
      { "<leader>cl", ":lua vim.diagnostic.setloclist()<cr>",               desc = "Location List" },
      { "<leader>cq", ":lua vim.diagnostic.setqflist()<cr>",                desc = "Quickfix List" },

      { "<leader>u",  group = "ui", },
      { "<leader>us", ":set spell!<cr>",                                    desc = "Toggle Spell" },
      { "<leader>uw", ":set wrap!<cr>",                                     desc = "Toggle Wrap" },

      { "<leader>s",  group = "search",                                     mode = { "n", "x" } },
      -- { "<leader>sM", function() Snacks.picker.man() end,         desc = "Man Pages" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    },
	},
}
