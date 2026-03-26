return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local lualine = require("lualine")
		local colors = {
			bg = "#011627",
			fg = "#9399b1",
			yellow = "#ffc777",
			cyan = "#008080",
			green = "#c3e88d",
			orange = "#ff8800",
			magenta = "#c678dd",
			blue = "#65bcff",
			red = "#ff5189",
		}

		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = {
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						function()
							return " "
						end,
						color = function()
							local mode_color = {
								n = colors.blue,
								no = colors.green,
								v = colors.magenta,
								V = colors.magenta,
								[""] = colors.magenta,
								s = colors.orange,
								S = colors.orange,
								[""] = colors.orange,
								i = colors.green,
								ic = colors.yellow,
								R = colors.red,
								Rv = colors.red,
								c = colors.yellow,
								cv = colors.green,
								ce = colors.green,
								r = colors.cyan,
								rm = colors.cyan,
								["r?"] = colors.cyan,
								["!"] = colors.green,
								t = colors.green,
							}
							return { fg = mode_color[vim.fn.mode()] }
						end,
						padding = { right = 1 },
					},
					{ "location" },
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				lualine_x = {
					{ "branch", icon = "" },
					{
						"diff",
						symbols = { added = "⊠ ", modified = "⊡ ", removed = "⊟ " },
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
		}

		lualine.setup(config)
	end,
}
