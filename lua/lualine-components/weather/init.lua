local weather = ""

local update_weather
update_weather = function()
	vim.fn.jobstart('curl -s -m 30 "wttr.in/Vilnius?format=%t" | tr -d "[:blank:]"', {
		detach = false,
		stdout_buffered = true,
		on_stdout = function(chan_id, stdout)
			weather = stdout[1]
		end,
		on_exit = function()
			local mins30 = 1000 * 60 * 30
			vim.defer_fn(update_weather, mins30)
		end,
	})
end
update_weather()

return function()
	return weather
end
