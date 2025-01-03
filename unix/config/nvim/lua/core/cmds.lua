-- AutoCommands --
-- nvim_create_augroup      = Create or get an augroup.
-- nvim_create_autocmd      = Create an autocmd.
-- nvim_del_augroup_by_id   = Delete an augroup by id.
-- nvim_del_augroup_by_name = Delete an augroup by name.
-- nvim_del_autocmd         = Delete an autocmd by id.
-- nvim_do_autocmd          = Do one autocmd.
-- nvim_get_autocmds        = Get autocmds that match the requirements.

local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- When entering Neovim
api.nvim_create_autocmd({ "VimEnter" }, { pattern = "*", command = "Focus" })

-- Format on save
api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
