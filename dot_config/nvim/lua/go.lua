local M = {}

local kn_l_map = require("keymappings").kn_l_map
local Augroup = require('kautocmd').Augroup


function M.setup()
	local go_group = Augroup:new("gogroup")
	go_group:add_cmd("FileType", {
	  pattern = "go",
	  callback = function()
		kn_l_map("gi", ":GoImports<cr>")
		kn_l_map("gf", ":GoFmt<cr>")
		kn_l_map("gb", ":GoBuild<cr>")
		kn_l_map("gd", ":GoDef<cr>")
		kn_l_map("ge", ":GoTest<cr>")
	  end,
	})
end
  
return M
  