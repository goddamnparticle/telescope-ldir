local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}
local ldir_maker
local setup_config

M.setup = function(config)
	setup_config = config
	ldir_maker = function(entry)
		local path_remove = function(String)
            local retstr = string.gsub(String, setup_config.ldir_path .. "/", "")
			return string.gsub(retstr, "/", "")
		end
		local disp = path_remove(entry)
		return { value = entry, display = disp, ordinal = disp }
	end
end

M.ldir = function(opts)
	opts = opts or {}
	local input = { "fd", "--type", "d", "--maxdepth", "1", ".", setup_config.ldir_path }
	pickers.new(opts, {
		prompt_title = "Neovim Installed Plugins",
		finder = finders.new_oneshot_job(input, { entry_maker = ldir_maker }),
		sorter = conf.generic_sorter(opts),
	}):find()
end

return M
