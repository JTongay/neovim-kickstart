return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.keymap.set("n", "<leader>t", ":TestFile<CR>", {})
    vim.keymap.set("n", "<leader>T", ":TestNearest<CR>", {})
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
    vim.keymap.set("n", "<leader>s", ":TestSuite<CR>", {})
    vim.keymap.set("n", "<leader>v", ":TestVisit<CR>", {})
    vim.keymap.set("n", "<leader>q", ":TestQuit<CR>", {})
    vim.cmd("let test#strategy = 'vimux'")
  end
}
