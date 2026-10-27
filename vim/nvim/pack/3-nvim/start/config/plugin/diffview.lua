-- Swap diffview's two diff windows (new version on the left, old on the right).
-- Swap by window id so it doesn't matter which window has focus.
vim.api.nvim_create_autocmd("User", {
  pattern = "DiffviewViewOpened",
  callback = function()
    vim.schedule(function()
      local view = require("diffview.lib").get_current_view()
      local layout = view and view.cur_layout
      if not (layout and layout.a and layout.b) then
        return
      end
      local a, b = layout.a.id, layout.b.id
      if vim.api.nvim_win_is_valid(a) and vim.api.nvim_win_is_valid(b) then
        local cur = vim.api.nvim_get_current_win()
        vim.api.nvim_win_call(a, function()
          vim.cmd("wincmd x")
        end)
        if vim.api.nvim_win_is_valid(cur) then
          vim.api.nvim_set_current_win(cur)
        end
      end
    end)
  end,
})
