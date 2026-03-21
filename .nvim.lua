-- Project-local config for ~/.dotfiles
-- Shows hidden files in telescope (excluding .git)
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", function()
	builtin.find_files({
		hidden = true,
		file_ignore_patterns = { "%.git" },
	})
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>sg", function()
	builtin.live_grep({
		additional_args = { "--hidden", "--glob", "!.git" },
	})
end, { desc = "[S]earch by [G]rep" })
