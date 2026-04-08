local _cache = {}

vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "DirChanged", "BufEnter" }, {
	callback = function(event)
		_cache[event.buf] = nil
	end,
})

local function root_dir()
	local buf = vim.api.nvim_get_current_buf()
	if _cache[buf] then
		return _cache[buf]
	end

	local name = vim.api.nvim_buf_get_name(buf)
	local bufpath = name ~= "" and (vim.uv.fs_realpath(name) or name) or nil
	local roots = {}

	-- LSP
	if bufpath then
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
			for _, ws in ipairs(client.workspace_folders or {}) do
				local path = vim.uv.fs_realpath(vim.uri_to_fname(ws.uri))
				if path and not vim.tbl_contains(roots, path) and bufpath:find(path, 1, true) == 1 then
					roots[#roots + 1] = path
				end
			end

			local root = client.root_dir or client.config.root_dir
			root = root and vim.uv.fs_realpath(root) or nil
			if root and not vim.tbl_contains(roots, root) and bufpath:find(root, 1, true) == 1 then
				roots[#roots + 1] = root
			end
		end
	end

	if #roots > 1 then
		table.sort(roots, function(a, b)
			return #a > #b
		end)
	end

	local ret = roots[1]

	-- .git
	if not ret then
		local path = bufpath and vim.fs.dirname(bufpath) or vim.uv.cwd()
		local pattern = vim.fs.find(".git", { path = path, upward = true })[1]
		ret = pattern and vim.fs.dirname(pattern) or nil
	end

	-- cwd
	ret = ret or vim.uv.cwd() or ""

	-- Normalize
	ret = vim.uv.fs_realpath(ret) or ret

	_cache[buf] = ret
	return ret
end

return root_dir
