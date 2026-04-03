return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
		{ "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
		{ "[B", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer to Left" },
		{ "]B", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer to Right" },
	},
	opts = {
		options = {
			show_buffer_icons = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			show_tab_indicators = false,
			modified_icon = "",
			left_trunc_marker = "‹",
			right_trunc_marker = "›",
			offsets = {
				{
					filetype = "NvimTree",
					text = "Explorer",
					highlight = "Directory",
					text_align = "center",
				},
			},
			separator_style = "thick",
			always_show_bufferline = false,
		},
	},
}
