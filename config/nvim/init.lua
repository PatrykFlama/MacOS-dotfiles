vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- uses the macOS clipboard
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.undofile = true -- persistent undo across sessions
opt.splitright = true
opt.splitbelow = true

-- Tokyo Night Moon, same palette as Ghostty and tmux (plugin installed by Nix).
if not pcall(vim.cmd.colorscheme, "tokyonight-moon") then
  vim.cmd.colorscheme("habamax")
end

-- Treesitter highlighting (grammars are installed by Nix).
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Move between splits with ctrl+hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- macOS-style arrow navigation. Ghostty sends readline codes for these keys:
-- ⌥←/⌥→ = Esc b / Esc f (seen by Neovim as <M-b>/<M-f>), ⌘←/⌘→ = Ctrl-A / Ctrl-E.
map({ "n", "x", "o" }, "<M-b>", "b", { desc = "Word left" })
map({ "n", "x", "o" }, "<M-f>", "w", { desc = "Word right" })
map("i", "<M-b>", "<C-o>b", { desc = "Word left" })
map("i", "<M-f>", "<C-o>w", { desc = "Word right" })
map("c", "<M-b>", "<S-Left>", { desc = "Word left" })
map("c", "<M-f>", "<S-Right>", { desc = "Word right" })
map({ "n", "x", "o" }, "<C-a>", "^", { desc = "Line start" })
map({ "n", "x", "o" }, "<C-e>", "$", { desc = "Line end" })
map("i", "<C-a>", "<C-o>^", { desc = "Line start" })
map("i", "<C-e>", "<End>", { desc = "Line end" })
map("c", "<C-a>", "<Home>", { desc = "Line start" })
-- Ctrl-A / Ctrl-X (increment / decrement number) moved to leader +/-.
map({ "n", "x" }, "<leader>+", "<C-a>", { desc = "Increment number" })
map({ "n", "x" }, "<leader>-", "<C-x>", { desc = "Decrement number" })
