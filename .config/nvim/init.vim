:set number
:set mouse=a
:set autoindent
:set shiftwidth=4
:set smarttab
:set tabstop=4
:set softtabstop=4
:set wildmenu

call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'https://github.com/herringtondarkholme/yats.vim'
Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'andweeb/presence.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'https://github.com/m4xshen/autoclose.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'https://github.com/BurntSushi/ripgrep'
Plug 'romgrk/barbar.nvim'

call plug#end()

let NERDTreeShowHidden=1

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-t> :belowright split<CR>:resize 10<CR>:term<CR>
nnoremap ff :Telescope find_files<CR>
nnoremap fg :Telescope live_grep<CR>
nnoremap <C-s> :w<CR>

" Allow Wrapping when cursor is at beginning/end of line
:set whichwrap+=>,l
:set whichwrap+=<,h

nnoremap <C-m> :TagbarToggle<CR>
nnoremap <C-'> :call <SID>show_documentation()<CR>
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
inoremap <silent><expr> <c-Space> coc#pum#visible() ? coc#pum#stop() : coc#refresh()

nnoremap <C-c> "+y
vnoremap <C-c> "+y
nnoremap <C-p> "+p
vnoremap <C-p> "+p

:tnoremap <Esc> <C-\><C-n>

:colorscheme space-vim-dark

:hi Cursor guifg=green guibg=green
:hi Cursor2 guifg=red guibg=red
:set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

highlight DiagnosticHint ctermfg=lightblue guifg=#00ffff

lua << END
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }
require("autoclose").setup()
END
