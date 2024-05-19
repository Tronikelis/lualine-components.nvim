local default_options = {
	city = "Vilnius",
}

local M = require("lualine.component"):extend()

M.weather = ""

function M:update_weather()
	local cmd = 'curl -s -m 30 "wttr.in/' .. self.options.city .. '?format=%t" | tr -d "[:blank:]"'

	vim.fn.jobstart(cmd, {
		detach = false,
		stdout_buffered = true,
		on_stdout = function(chan_id, stdout)
			self.weather = stdout[1]
		end,
		on_exit = function()
			local mins30 = 1000 * 60 * 30

			vim.defer_fn(function()
				self.update_weather(self)
			end, mins30)
		end,
	})
end

function M:init(options)
	M.super.init(self, options)
	self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)

	self.update_weather(self)
end

function M:update_status()
	return self.weather
end

return M
