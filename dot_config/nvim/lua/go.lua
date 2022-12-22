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

function M.function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

return M
  
