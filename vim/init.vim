set runtimepath^=~/.dotfiles runtimepath+=~/.vim/after
let packpath = &runtimepath
source ~/.vimrc

:au VimLeave * set gcr=a:ver100-blinkoff0

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20
augroup END

lua << EOF
if vim.g.neovide then
    vim.o.guifont = "Roboto Mono Light for Powerline:h15"
    vim.g.transparency = 0.9
    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_trail_size = 0.3
    vim.g.neovide_cursor_animate_command_line = false

    vim.g.neovide_input_use_logo = 1 -- use cmd key instead of ctrl

    -- nvim's copy-paste mappings
    vim.keymap.set('v', '<D-c>', '"+y') -- copy
    vim.keymap.set('n', '<D-v>', '"+P') -- paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- paste insert mode

    -- allow clipboard copy-paste in neovim
    vim.api.nvim_set_keymap('' , '<D-v>', '+p<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', {noremap = true, silent = true})
end
EOF
