-- Options
local set = vim.opt

-- display
set.number = true         -- Make line numbers default (default: false)
set.relativenumber = true -- Set relative numbered lines (default: false)
set.cursorline = true     -- Highlight the current line (default: false)

-- search
set.hlsearch = true  -- Set highlight on search (default: true)
set.incsearch = true
set.showmatch = true -- TODO: Do I need this?

-- edit
set.autoindent = true -- Copy indent from current line when starting new one (default: true)
set.tabstop = 4       -- Insert n spaces for a tab (default: 8)
set.softtabstop = 4   -- Number of spaces that a tab counts for while performing editing operations (default: 0)
set.shiftwidth = 4    -- The number of spaces inserted for each indentation (default: 8)
set.expandtab = true  -- Convert tabs to spaces (default: false)
set.virtualedit = "block"
set.undofile = true   -- Save undo history (default: false)

-- cursor movement
set.whichwrap = 'b,s,h,l,[,]' -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
set.scrolloff = 3             -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)

-- display
set.wrap = false -- Display lines as one long line (default: true)

-- split windows
set.splitright = true -- Force all vertical splits to go to the right of current window (default: false)

-- speed
set.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)

-- completion
set.completeopt = 'menu,preview'     -- Set completeopt to have a better completion experience (default: 'menu,preview')
set.formatoptions:remove({ 'r', 'o' }) -- Don't insert the current comment leader automatically for auto-wrapping comments using, hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')

-- clipboard
if vim.fn.has('clipboard') then
	-- clipboard provider avaiable
	set.clipboard:append({ "unnamedplus" }) -- Sync clipboard between OS and Neovim. (default: '')
end
