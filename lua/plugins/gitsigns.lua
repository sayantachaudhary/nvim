return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "ǀ" },
			change = { text = "⦚" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
		},
		signs_staged = {
			add = { text = "ǀ" },
			change = { text = "⦚" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
		},

		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next Hunk")

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Prev Hunk")

      -- stylua: ignore start
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "x" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "x" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = false }) end, "Blame Line")
      map("n", "<leader>gB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>gd", gs.diffthis, "Diff This")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk") -- Text object
		end,
	},
}
