-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- easier indenting of code blocks
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Open neotree
vim.keymap.set('n', '<leader>e', ":Neotree toggle<cr>", { desc = 'Open neotree' })
vim.keymap.set("n", "<leader>gs", ":Neotree float git_status<cr>", { desc = 'Open git status window' })

-- Open undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>dt', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = 'Toggle LSP diagnostic'})

