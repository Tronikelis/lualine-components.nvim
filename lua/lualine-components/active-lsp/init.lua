local M = require("lualine.component"):extend()

local sort_clients = function(a, b)
	local a_ft = a.config.filetypes or {}
	local b_ft = b.config.filetypes or {}

	return #a_ft > #b_ft
end

function M:update_prompt()
	local clients = vim.lsp.get_clients(self.options.filter)
	table.sort(clients, self.options.sort_clients)

	for _, v in ipairs(clients) do
		if not vim.tbl_contains(self.options.exclude, v.name) then
			self.prompt = v.name
		end
	end
end

function M:init(options)
	M.super.init(
		self,
		vim.tbl_deep_extend("force", {
			icon = "󰣖",
			filter = { bufnr = 0 },
			sort_clients = sort_clients,
			exclude = {},
			refresh_autocmd = { "LspAttach", "LspDetach", "BufEnter" },
		}, options)
	)

	self.prompt = ""

	vim.api.nvim_create_autocmd(self.options.refresh_autocmd, {
		callback = function()
			-- LspDetach runs right before, so try to run right after
			vim.schedule(function()
				self:update_prompt()
			end)
		end,
	})
end

function M:update_status()
	return self.prompt
end

return M
