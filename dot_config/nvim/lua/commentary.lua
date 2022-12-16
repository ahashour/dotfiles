local M = {}

local kn_l_map = require("keymappings").kn_l_map
local kv_l_map = require("keymappings").kv_l_map

function M.setup()
    kn_l_map("/", ":Commentary<cr>")
    kv_l_map("/", ":Commentary<cr>")
end
  
return M
