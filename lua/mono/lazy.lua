local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[When creating a new folder make sure to reference it by using
{import="name/of/new/folder"},]]
require("lazy").setup({
    {import = "mono.plugins"},
    {import = "mono.plugins.syntax"},
    {import = "mono.plugins.ui"},
    {import = "mono.plugins.lsp"},
    {import = "mono.plugins.completion"},
    {import = "mono.plugins.misc"},
})
