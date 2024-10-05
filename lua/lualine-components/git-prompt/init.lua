local M = require("lualine.component"):extend()

function M:init(options)
	if not options.color then
		local fg = vim.api.nvim_get_hl(0, { name = "Error" }).fg
		options.color = {
			fg = string.format("#%x", fg),
		}
	end

	M.super.init(self, options)

	self._prompt = ""
	self._running = false
end

function M:update_status()
	if self._running then
		return
	end
	self._running = true

	local function parse(git_status)
		if not git_status then
			return
		end

		local lines = vim.split(git_status, "\n", { trimempty = true })
		for i, _ in ipairs(lines) do
			lines[i] = vim.trim(lines[i])
			lines[i] = lines[i]:sub(1, 1)
		end

		vim.fn.uniq(lines)
		table.sort(lines)

		self._prompt = vim.fn.join(lines, "")
	end
	parse = vim.schedule_wrap(parse)

	vim.system({ "git", "status", "--porcelain" }, {}, function(obj)
		parse(obj.stdout)
		self._running = false
	end)

	return self._prompt
end

return M
