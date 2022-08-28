local has_telescope, telescope = pcall(require, "telescope")
local ldir = require("ldir.ldir")

if not has_telescope then
	error("This plugins requires nvim-telescope/telescope.nvim")
end

return telescope.register_extension({
	setup = ldir.setup,
	exports = { ldir = ldir.ldir },
})
