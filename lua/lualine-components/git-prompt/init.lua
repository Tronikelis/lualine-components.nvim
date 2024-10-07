local M = require("lualine.component"):extend()

-- making these global, because git runs on cwd anyway, so all buffers will be the same
local prompt = ""
local running = false

function M:init(options)
	if not options.color then
		local fg = vim.api.nvim_get_hl(0, { name = "Error" }).fg
		options.color = {
			fg = string.format("#%x", fg),
		}
	end

	M.super.init(self, options)
end

function M:update_status()
	if running then
		return prompt
	end
	running = true

	local function parse(git_status)
		if not git_status then
			return
		end

		local statuses = {}

		local lines = vim.split(git_status, "\n", { trimempty = true })
		for _, line in ipairs(lines) do
			line = vim.trim(line)
			line = vim.split(line, " ", { trimempty = true })[1]

			for _, status in ipairs(vim.split(line, "", { trimempty = true })) do
				table.insert(statuses, status)
			end
		end

		statuses = vim.fn.uniq(statuses)
		table.sort(statuses)

		prompt = vim.fn.join(statuses, "")
	end
	parse = vim.schedule_wrap(parse)

	vim.system({ "git", "status", "--porcelain" }, {}, function(obj)
		parse(obj.stdout)
		running = false
	end)

	return prompt
end

return M
