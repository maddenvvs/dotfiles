-- Adopted from the LazyVim VSCode extras plugin:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/vscode.lua

if not vim.g.vscode then
    return {}
end

local enabled = {
    "dial.nvim",
    "flit.nvim",
    "lazy.nvim",
    "leap.nvim",
    "mini.ai",
    "mini.comment",
    "mini.move",
    "mini.pairs",
    "mini.surround",
    "nvim-treesitter",
    "nvim-treesitter-textobjects",
    "nvim-ts-context-commentstring",
    "snacks.nvim",
    "ts-comments.nvim",
    "vim-repeat",
    "yanky.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
    return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- Globally disable Snacks animations.
-- https://github.com/folke/snacks.nvim/blob/main/docs/animate.md
vim.g.snacks_animate = false

vim.keymap.set("n", "<Leader>p", "<Cmd>Find<CR>")
vim.keymap.set("n", "<leader>/", [[<Cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>]])
vim.keymap.set("n", "<leader>ss", [[<Cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>]])
vim.keymap.set("n", "<leader>sS", [[<Cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>]])

-- Keep undo/redo lists in sync with VSCode.
vim.keymap.set("n", "u", [[<Cmd>lua require('vscode').action('undo')<CR>]])
vim.keymap.set("n", "<C-r>", [[<Cmd>lua require('vscode').action('redo')<CR>]])

-- Navigate VSCode tabs like buffers.
vim.keymap.set("n", "<S-h>", [[<Cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>]])
vim.keymap.set("n", "<S-l>", [[<Cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>]])
vim.keymap.set("n", "<Leader>bo", [[<Cmd>lua require('vscode').action('workbench.action.closeOtherEditors')<CR>]])

return {
    {
        "snacks.nvim",
        opts = {
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            indent = { enabled = false },
            input = { enabled = false },
            notifier = { enabled = false },
            picker = { enabled = false },
            quickfile = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { highlight = { enable = false } },
    },
}
