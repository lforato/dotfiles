function Open_bookmarks()
	local home = os.getenv("HOME")
	local marks_file = home .. "/marks.txt"

	local file = io.open(marks_file, "r")

	if not file then
		local new_file = io.open(marks_file, "w")
		if new_file then
			new_file:close()
			print("Created new bookmarks file: " .. marks_file)
		else
			print("Failed to create bookmarks file: " .. marks_file)
			return
		end
		return
	end

	vim.cmd("vsplit " .. marks_file)
end

-- Create a Neovim command :Bm that runs the function
vim.api.nvim_create_user_command("Bm", function()
	Open_bookmarks()
end, {})
