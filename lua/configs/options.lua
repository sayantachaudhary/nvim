local o = vim.opt
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.ignorecase = true
o.smartcase = true
o.splitright = true
o.splitbelow = true
o.wrap = false
o.showmode = false
o.laststatus = 3
o.confirm = true
o.signcolumn = "yes"
o.cursorline = true
o.scrolloff = 4
o.sidescrolloff = 8
o.undofile = true
o.updatetime = 250
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldtext = ""
o.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
o.clipboard = "unnamedplus"
o.shortmess:append("cC")
o.whichwrap:append("<>[]hl")
vim.g.markdown_recommended_style = 0

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
