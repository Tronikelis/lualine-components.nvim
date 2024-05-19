local default_options = {
	city = "Vilnius",
}

local M = require("lualine.component").extend()

M.weather = ""

M.update_weather = function(self)
	local cmd = 'curl -s -m 30 "wttr.in/' .. self.options.city .. '?format=%t" | tr -d "[:blank:]"'

	vim.fn.jobstart(cmd, {
		detach = false,
		stdout_buffered = true,
		on_stdout = function(chan_id, stdout)
			M.weather = stdout[1]
		end,
		on_exit = function()
			local mins30 = 1000 * 60 * 30

			vim.defer_fn(function()
				self.update_weather(self)
			end, mins30)
		end,
	})
end

M.init = function(self, options)
	M.super.init(self, options)
	self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)

	self.update_weather(self)
end

M.update_status = function(self)
	return self.weather
end

return M
