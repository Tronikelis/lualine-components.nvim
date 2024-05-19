local M = require("lualine.component"):extend()

function M:update_status()
	local mode = require("lualine.utils.mode").get_mode()
	return string.sub(mode, 1, 1)
end

return M
