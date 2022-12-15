vim.g.NERDTreeAutoDeleteBuffer = 1
-- vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHidden = 1
-- vim.g.NERDTreeShowLineNumbers = 0
-- vim.g.NERDTreeCascadeSingleChildDir = 0
-- vim.g.NERDTreeDirArrowExpandable = "•"
-- vim.g.NERDTreeDirArrowCollapsible = "•"
-- vim.g.NERDTreeHighlightCursorline = 0
vim.g.NERDTreeWinSize = 31
-- vim.g.NERDTreeStatusline = "%#NonText#"
vim.g.NERDTreeIgnore = {
	"\\.pyc$", 
	"^node_modules$", 
	"\\.git$[[dir]]",
}
vim.g.NERDTreeChDirMode = 0
vim.g.NERDTreeMouseMode=3
-- vim.opt.rtp = vim.popt.rtp + '~/.vim/plugged/nerdtree'
vim.opt.rtp = vim.opt.rtp + '~/.local/share/nvim/site/pack/packer/start/nerdtree'
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
	Modified = "✹",
	Staged = "✚",
	Untracked = "✭",
	Renamed = "➜",
	Unmerged = "═",
	Deleted = "✖",
	Dirty = "✗",
	Clean = "✔︎",
	Ignored = "☒",
	Unknown = "?",
}
vim.opt.backspace = {
	"start",
	"eol",
	"indent",
}