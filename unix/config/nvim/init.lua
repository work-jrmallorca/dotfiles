vim.loader.enable()

for _, source in ipairs({
  -- CORE
  "core.maps",
  "core.package-manager",
  "core.opts",
  "core.cmds",
  "core.colors",

  -- PLUGINS
  "plugins.telescope",
  "plugins.gruvbox",
  "plugins.gitsigns",
  "plugins.true-zen",
  "plugins.mason",
  "plugins.null-ls",
  "plugins.lspconfig",
  "plugins.nvim-cmp",
  "plugins.nvim-autopairs",
  "plugins.neotest",
  "plugins.nvim-dap",
  "plugins.commented",
  "plugins.nvim-treesitter",
  "plugins.hop",
  "plugins.telekasten",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end
