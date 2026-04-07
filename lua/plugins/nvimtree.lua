local function root_dir()
	local file = vim.api.nvim_buf_get_name(0)
	local dir = file ~= "" and vim.fs.dirname(file) or vim.uv.cwd()
	local root = vim.fs.find({ ".git", "package.json" }, { upward = true, path = dir })[1]
	return root and vim.fs.dirname(root) or dir
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	keys = {
		{
			"<leader>e",
			function()
				vim.cmd("cd " .. root_dir())
				vim.cmd("NvimTreeToggle")
			end,
			desc = "Explorer",
		},
		{
			"<leader>E",
			function()
				local cwd = vim.fn.expand("%:p:h")
				if cwd ~= "" then
					vim.cmd("cd " .. cwd)
				end
				vim.cmd("NvimTreeToggle")
			end,
		},
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- LSP-integrated file renaming
		local prev = { new_name = "", old_name = "" }
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})

		require("nvim-tree").setup({
			filters = { dotfiles = true },
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				width = 30,
				preserve_window_proportions = true,
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				indent_markers = {
					enable = true,
					icons = {
						corner = "▏",
						edge = "▏",
						item = "▏",
						bottom = "",
					},
				},
				icons = {
					git_placement = "after",
					symlink_arrow = "  ",
					glyphs = {
						default = "",
						symlink = "󰌷",
						bookmark = "",
						folder = {
							arrow_closed = "›",
							arrow_open = "⌄",
							default = "",
							open = "",
							empty = "",
							empty_open = "󰜌",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "~",
							staged = "",
							unmerged = "",
							renamed = "",
							untracked = "?",
							deleted = "—",
							ignored = "",
						},
					},
				},
			},
		})
	end,
}
