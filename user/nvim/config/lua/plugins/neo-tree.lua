return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        }
    end,
    vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle),
    vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeFocus)
}
