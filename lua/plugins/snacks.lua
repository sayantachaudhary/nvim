local function term_nav(dir)
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

local function root_dir()
	local file = vim.api.nvim_buf_get_name(0)
	local dir = file ~= "" and vim.fs.dirname(file) or vim.uv.cwd()
	local root = vim.fs.find({ ".git", "package.json" }, { upward = true, path = dir })[1]
	return root and vim.fs.dirname(root) or dir
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
  -- stylua: ignore start
  keys = {
    { "<leader>f",  function() Snacks.picker.files({ cwd = root_dir() }) end,            desc = "Files" },
    { "<leader>F",  function() Snacks.picker.files({ cwd = vim.fn.expand("%:p:h") }) end },
    { "<leader>sg", function() Snacks.picker.grep({ cwd = root_dir() }) end,             desc = "Grep" },
    { "<leader>sG", function() Snacks.picker.grep() end },
    { "<leader>sw", function() Snacks.picker.grep_word({ cwd = root_dir() }) end,        desc = "Grep Word",        mode = { "n", "x" } },
    { "<leader>sW", function() Snacks.picker.grep_word() end,                            mode = { "n", "x" } },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                          desc = "Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                desc = "Workspace Symbols" },
    -- { "<leader>sM", function() Snacks.picker.man() end,                                  desc = "Man Pages" },
    { "<C-/>",      function() Snacks.terminal() end,                                    desc = "Toggle Terminal" },
    { "<C-_>",      function() Snacks.terminal() end,                                    desc = "which_key_ignore" },
  },
  opts = {
    bigfile = { notify = false },
    image = { doc = { inline = false } },
    styles = {
      snacks_image = {
        relative = "editor",
        col = -1,
      },
    },
    input = { icon = "" },
    lazygit = { configure = false },
    terminal = {
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav("h"), expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav("j"), expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav("k"), expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav("l"), expr = true, mode = "t" },
        },
      },
    },
    indent = {
      indent = { char = "▏" },
      scope = { char = "▏" },
      animate = { enabled = false },
    },
    picker = {
      icons = {
        files = { dir_open = "", file = "" },
        ui = { live = "⚡" },
        kinds = {
          Boolean     = "",
          Constant    = "П",
          Constructor = "",
          Enum        = "",
          EnumMember  = "",
          Field       = "",
          Function    = "ƒ",
          Interface   = "",
          Key         = "",
          Method      = "",
          Module      = "󰩦",
          Null        = "",
          Operator    = "",
          Package     = "",
          Reference   = "",
          Snippet     = "",
          String      = "",
          Struct      = "",
          Text        = "",
          Unit        = "",
          Variable    = "",
        },
      }
    },
  },
}
