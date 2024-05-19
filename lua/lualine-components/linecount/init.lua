return function()
	local count = vim.api.nvim_buf_line_count(0)

	if count >= 1000 then
		count = count / 1000

		local dotIndex = string.find(count, ".", 1, true)

		if dotIndex ~= nil then
			count = string.sub(count, 1, dotIndex + 1)
		else
			count = count .. ".0"
		end

		count = count .. "K"
	end

	return count
end
