require "nvchad.options"

local o = vim.o

o.title = true
o.cursorlineopt = "both"
o.relativenumber = true
o.virtualedit = "onemore"
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false
o.number = true
