return {
	{
		"brenoprata10/nvim-highlight-colors",
		keys = {
			{
				"<leader>uh",
				function()
					local hc = require("nvim-highlight-colors")
					if hc.is_on then
						hc.turnOff()
					else
						hc.turnOn()
					end
					hc.is_on = not hc.is_on
				end,
				desc = "Highlight Colors",
			},
		},
		opts = {
			render = "virtual",
			enable_tailwind = true,
		},
	},

	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 200,
				large_file_cutoff = 2000,
				min_count_to_highlight = 2,
        -- stylua: ignore
        keys = {
          { "A-n", function() require("illuminate").goto_next_reference() end },
          { "A-p", function() require("illuminate").goto_prev_reference() end },
        },
			})
		end,
	},
	-- {
	-- 	"nvim-mini/mini.pairs",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		modes = { insert = true, command = true },
	-- 	},
	-- },

	-- {
	-- 	"christoomey/vim-tmux-navigator",
	-- 	event = function()
	-- 		if vim.fn.exists("$TMUX") == 1 then
	-- 			return "VeryLazy"
	-- 		end
	-- 	end,
	-- },
}
