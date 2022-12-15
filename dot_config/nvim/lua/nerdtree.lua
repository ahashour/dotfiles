local M = {}

local kn_l_map = require("keymappings").kn_l_map
local Augroup = require('kautocmd').Augroup

--  sync open file with NERDTree
--  Check if NERDTree is open or active
-- local function IsNERDTreeOpen()
--     return vim.api.exists("t:NERDTreeBufName") and (vim.api.bufwinnr("t:NERDTreeBufName") ~= -1)
-- end

function M.setup()
  kn_l_map("t", ":NERDTreeFocus<cr>")
	local nerdtree_group = Augroup:new("nerdtreegroup")
  nerdtree_group:add_cmd("StdinReadPre", {
    pattern = "*",
    command = [[ let s:std_in=1 ]],
  })
  
  nerdtree_group:add_cmd("VimEnter", {
    pattern = "*",
    command = [[ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif ]],
  })

  -- Make NERDTree open automatically on startup
  -- nerdtree_group:add_cmd({"VimEnter"}, {
  --   command = "NERDTree"
  -- })

  nerdtree_group:add_cmd("BufEnter", {
    pattern = "*",
    command = [[ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]],
  })

  -- Close vim if the only window left is NERDTree
  nerdtree_group:add_cmd({"BufEnter"}, {
    command =  [[ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]]
  })

  vim.cmd([[
    function! g:NERDTreeCustomToggle()
      let g:curnerdtreetogglewnum = winnr()
      if g:NERDTree.IsOpen()
        exec "NERDTreeClose"
        if &modifiable && @% != "" && !isdirectory(@%)
          exec g:curnerdtreetogglewnum . "wincmd ="
        endif
      elseif &modifiable && @% != "" && !isdirectory(@%)
        exec "NERDTreeFind"
        exec "set winfixwidth"
        exec g:curnerdtreetogglewnum . "wincmd ="
          else
            exec "NERDTreeCWD"
            exec "set winfixwidth"
            exec g:curnerdtreetogglewnum . "wincmd ="
          endif
        endif
    endfunction
    
    " ctrlp
    " let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    
    " sync open file with NERDTree
    " " Check if NERDTree is open or active
    function! IsNERDTreeOpen()
      return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    endfunction
    
    " Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
    " file, and we're not in vimdiff
    function! SyncTree()
      if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
      endif
    endfunction
    
    " Highlight currently open buffer in NERDTree
    autocmd BufEnter * call SyncTree()
  ]])

  -- nerdtree_group:add_cmd("BufEnter", {
  --   pattern = "*",
  --   callback = function()
  --     SyncTree()
  --   end,
  -- })
  
end
  
return M