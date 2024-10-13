local M = require("lualine.component"):extend()

function M:parse_git_status()
	if self.running then
		return
	end
	self.running = true

	vim.system(
		{ "git", "status", "--porcelain" },
		{},
		vim.schedule_wrap(function(out)
			self.running = false

			if not out.stdout then
				return
			end

			local statuses = {}

			local lines = vim.split(out.stdout, "\n", { trimempty = true })
			for _, line in ipairs(lines) do
				line = vim.trim(line)
				line = vim.split(line, " ", { trimempty = true })[1]

				for _, status in ipairs(vim.split(line, "", { trimempty = true })) do
					table.insert(statuses, status)
				end
			end

			statuses = vim.fn.uniq(statuses)
			table.sort(statuses)

			self.prompt = vim.fn.join(statuses, "")
		end)
	)
end

function M:init(options)
	self.prompt = ""
	self.running = false

	if not options.color then
		local fg = vim.api.nvim_get_hl(0, { name = "Error" }).fg
		options.color = {
			fg = string.format("#%x", fg),
		}
	end

	self:parse_git_status()
	vim.api.nvim_create_autocmd({ "FocusGained", "BufWritePost", "DirChanged" }, {
		callback = function()
			self:parse_git_status()
		end,
	})

	M.super.init(self, options)
end

function M:update_status()
	return self.prompt
end

return M
