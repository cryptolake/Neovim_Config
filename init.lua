-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({

  -- themes
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},

  {
    "mbbill/undotree"
  }, -- undo tree
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim',
    dependencies = {  'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'  }
  },

  {
    "nvim-neotest/nvim-nio"
  },

  {'nvim-telescope/telescope-ui-select.nvim' },

  {'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  { "nvim-telescope/telescope-file-browser.nvim" },
  -- git and github integration
  {
    'lewis6991/gitsigns.nvim',
  },

  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },

  -- lsp stuff
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- 'j-hui/fidget.nvim',
    },
  },

  -- debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
    }
  },
  -- luasnip
  {
    'L3MON4D3/LuaSnip',
    build = "make install_jsregexp",
    dependencies = {
      'rafamadriz/friendly-snippets',
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'uga-rosa/cmp-dictionary'
    }
  },

  -- autopairs
  'windwp/nvim-autopairs',

  -- visual stuff
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons', opt = true},
  },

  'ap/vim-css-color',

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  },

  {
    "tversteeg/registers.nvim",
    config = function()
      require("registers").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- Iron neovim
  {
    'hkupty/iron.nvim'
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
  },

  {
    'mfussenegger/nvim-lint'
  },

  {
    'jedrzejboczar/possession.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  },

  {
    'yacineMTB/dingllm.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },


})

-- Fix tabs
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Define a function to apply settings for C files
function setup_c_file()
  vim.bo.shiftwidth = 2
  vim.bo.tabstop = 2
  vim.bo.expandtab = false

  -- Add any additional commands you want to execute for C files here
  -- vim.cmd("your_custom_command_here")
end

-- Apply the settings for C files when FileType is detected
vim.cmd("autocmd FileType c lua setup_c_file()")

--Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.exrc = true
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = 'a'

-- vim.opt.laststatus = 3
--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undo'

-- auto change dir
-- vim.opt.autochdir = true

vim.opt.clipboard = 'unnamedplus'
--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[
set background=dark
colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE
]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- map keymaps using lua

local map = vim.keymap.set


-- very useful mappings
vim.cmd [[
" nvim tree toggle
nmap <leader>n <cmd>NvimTreeFindFileToggle<cr>
" Undo tree toggle
nmap <leader>u <cmd>UndotreeToggle<cr>
" Shortcutting split navigation, saving a keypress:
nmap <leader>w <C-w>
" Spell-check set to <leader>o, 'o' for 'orthography':
nmap <leader>o :setlocal spell! spelllang=en_us<CR>
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>
nnoremap <silent><leader>bd :bn<bar>bd!#<CR>
" moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Terminal mode
tnoremap <Esc> <C-\><C-n>
]]

--Set statusbar
require('lualine').setup {}
vim.opt.laststatus = 3

--Enable Comment.nvim
require('Comment').setup()

local ft = require('Comment.ft');

ft.set('c', '/*%s*/');

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- No line number with terminal
vim.cmd [[
  autocmd TermOpen * setlocal nonumber norelativenumber
]]


-- Gitsigns
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
-- Telescope
require('telescope').setup {
  pickers = {
    find_files = {
      no_ignore = false,
      hidden = true
    },
    buffers =  {
      mappings = {
        i = {
          ["<C-d>"] = 'delete_buffer'
        },
        n = {
          ["D"] = 'delete_buffer'
        }

      },
      sort_lastused = true,
    }

  }
}

-- Enable telescope fzf native
require("telescope").load_extension('fzf')
require("telescope").load_extension("ui-select")
--Add leader shortcuts

local telescope = require('telescope.builtin')

-- Telescope keymaps

map('n', '<leader>ff', telescope.find_files)
map('n', '<leader><leader>', function() telescope.buffers({
  sort_mru = true,
  ignore_current_buffer = true,
}) end)
map('n', '<leader>fb', telescope.buffers)
map('n', '<leader>f/', telescope.current_buffer_fuzzy_find)
map('n', '<leader>fh', telescope.help_tags)
map('n', '<leader>ft', telescope.tags)
map('n', '<leader>fd', telescope.grep_string)
map('n', '<leader>fg', telescope.live_grep)
map('n', '<leader>fo', telescope.oldfiles)
map('n', '<leader>fr', function() require 'telescope'.extensions.file_browser.file_browser() end)
map('n', '<leader>fs', telescope.lsp_document_symbols)
map('n', '<leader>fw', telescope.lsp_workspace_symbols)
map('n', '<leader>gb', telescope.git_branches)
map('n', '<leader>gf', telescope.git_files)
map('n', '<leader>gt', telescope.git_stash)
map('n', '<leader>gs', telescope.git_status)
map('n', '<leader>gc', telescope.git_commits)



-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {"html"},
  },
  indent = {
    enable = true,
    disable = {"c"}
  },
}


require("nvim-tree").setup({
  sync_root_with_cwd = true,
  filters = {
    dotfiles = false,
  },
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    -- update_root = true
  },
})
-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Neogit
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Neogit<CR>', { noremap = true, silent = true })

local neogit = require('neogit')
neogit.setup {}

-- LSP settings
-- lsp install

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = {noremap = true, silent = true}

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'pyright', 'ts_ls', 'lua_ls', 'rust_analyzer', 'zls' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Turn on status information
-- require('fidget').setup()

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        -- path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      -- workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        stubPath = "~/src/python-type-stubs",
        autoImportCompletions = false
      }
    }
  },
}

require('lspconfig').zls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    zig = {
      inlayHints = true,
      diagnostics = {
        enable = true,
      }
    }
  },

}

-- luasnip setup
--
local ls = require('luasnip')

map('i', '<C-e>', function()
  ls.expand()
end)


-- Setup nvim-cmp.
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
require('nvim-autopairs').setup{}
luasnip.config.setup {}
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
    }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}


-- Set configuration for specific filetype.
cmp.setup.filetype({'gitcommit', 'markdown'}, {
  sources = cmp.config.sources({
    { name = 'buffer' },
    {
      name = 'dictionary',
      keyword_length = 2
    }
  })
})

local dict = require("cmp_dictionary")

dict.setup({
  paths = {'/usr/share/dict/words'},
  exact_length = 2,
  first_case_insensitive = true,
  async = false,
  max_length_items = -1,
  debug = false,
  document = {
    enable = true,
    command = { "wn", "${label}", "-over" },
  },
})


-- linting 
--
require('lint').linters_by_ft = {
  -- python = {'pycodestyle', 'pydocstyle'}

}

local id = vim.api.nvim_create_augroup("LintGroup", {})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
  group = id
})
-- nvim DAP configuration

-- Automatically setup debuggers

require('dap.ext.vscode').load_launchjs(nil, {})
require("dapui").setup()
local dap, dapui =require("dap"),require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

map('n', '<leader>dq', function() dap.terminate() end)
map('n', '<leader>dc', function() dap.continue() end)
map('n', '<leader>do', function() dap.step_over() end)
map('n', '<leader>di', function() dap.step_into() end)
map('n', '<leader>du', function() dap.step_out() end)
map('n', '<Leader>db', function() dap.toggle_breakpoint() end)
-- map('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
map('n', '<Leader>dr', function() dap.repl.open() end)
map('n', '<Leader>dl', function() dap.run_last() end)
map({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
map({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
map('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
map('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)


require ('mason-nvim-dap').setup({
  ensure_installed = {'debugpy'},
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
  },
})

local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.split("40%"),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<leader>sc",
    visual_send = "<leader>sc",
    send_file = "<leader>sf",
    send_line = "<leader>sl",
    send_mark = "<leader>sm",
    mark_motion = "<leader>mc",
    mark_visual = "<leader>mc",
    remove_mark = "<leader>md",
    cr = "<leader>s<cr>",
    interrupt = "<leader>s<space>",
    exit = "<leader>sq",
    clear = "<leader>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
map('n', '<leader>rs', function() iron.repl() end)
map('n', '<leader>rr', function() iron.restart() end)
map('n', '<leader>rf', function() iron.focus() end)
map('n', '<leader>rh', function() iron.hide() end)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
  },
})

map('n', '<leader>Tr', function() require("neotest").run.run() end)
map('n', '<leader>Tf', function() require("neotest").run.run(vim.fn.expand("%")) end)
map('n', '<leader>Td', function() require("neotest").run.run({strategy = "dap"}) end)
map('n', '<leader>Tq', function() require("neotest").run.stop() end)
map('n', '<leader>Ta', function() require("neotest").run.attach() end)

-- Session management

require('possession').setup {
    plugins = {
        delete_hidden_buffers = {
            force = function(buf) return vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' end
      },
      delete_buffers = true,
    },
}

require('telescope').load_extension('possession')
map('n', '<leader>pp', function() require('telescope').extensions.possession.list()  end)
map('n', '<leader>ps', function() vim.cmd('PossessionSave') end)
map('n', '<leader>pq', function() vim.cmd('wa | qall') end)


-- AI
local dingllm = require("dingllm")
local system_prompt =
  'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
local helpful_prompt = 'You are a helpful assistant. What I have sent are my notes so far.'

--
-- local function handle_open_router_spec_data(data_stream)
--   local success, json = pcall(vim.json.decode, data_stream)
--   if success then
--     if json.choices and json.choices[1] and json.choices[1].text then
--       local content = json.choices[1].text
--       if content then
--         dingllm.write_string_at_cursor(content)
--       end
--     end
--   else
--     print("non json " .. data_stream)
--   end
-- end
--
-- local function custom_make_openai_spec_curl_args(opts, prompt)
--   local url = opts.url
--   local api_key = opts.api_key_name and os.getenv(opts.api_key_name)
--   local data = {
--     prompt = prompt,
--     model = opts.model,
--     temperature = 0.7,
--     stream = true,
--   }
--   local args = { '-N', '-X', 'POST', '-H', 'Content-Type: application/json', '-d', vim.json.encode(data) }
--   if api_key then
--     table.insert(args, '-H')
--     table.insert(args, 'Authorization: Bearer ' .. api_key)
--   end
--   table.insert(args, url)
--   return args
-- end
--
--
-- local function llama_405b_base()
--   dingllm.invoke_llm_and_stream_into_editor({
--     url = 'https://openrouter.ai/api/v1/chat/completions',
--     model = 'meta-llama/llama-3.1-405b',
--     api_key_name = 'OPEN_ROUTER_API_KEY',
--     max_tokens = '128',
--     replace = false,
--   }, custom_make_openai_spec_curl_args, handle_open_router_spec_data)
-- end
--
-- local function groq_replace()
--   dingllm.invoke_llm_and_stream_into_editor({
--     url = 'https://api.groq.com/openai/v1/chat/completions',
--     model = 'llama-3.1-70b-versatile',
--     api_key_name = 'GROQ_API_KEY',
--     system_prompt = system_prompt,
--     replace = true,
--   }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
-- end
--
-- local function groq_help()
--   dingllm.invoke_llm_and_stream_into_editor({
--     url = 'https://api.groq.com/openai/v1/chat/completions',
--     model = 'llama-3.1-70b-versatile',
--     api_key_name = 'GROQ_API_KEY',
--     system_prompt = helpful_prompt,
--     replace = false,
--   }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
-- end
--
-- local function llama405b_replace()
--   dingllm.invoke_llm_and_stream_into_editor({
--     url = 'https://api.lambdalabs.com/v1/chat/completions',
--     model = 'hermes-3-llama-3.1-405b-fp8',
--     api_key_name = 'LAMBDA_API_KEY',
--     system_prompt = system_prompt,
--     replace = true,
--   }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
-- end
--
-- local function llama405b_help()
--   dingllm.invoke_llm_and_stream_into_editor({
--     url = 'https://api.lambdalabs.com/v1/chat/completions',
--     model = 'hermes-3-llama-3.1-405b-fp8',
--     api_key_name = 'LAMBDA_API_KEY',
--     system_prompt = helpful_prompt,
--     replace = false,
--   }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
-- end

local function anthropic_help()
  dingllm.invoke_llm_and_stream_into_editor({
    url = 'https://api.anthropic.com/v1/messages',
    model = 'claude-3-5-sonnet-20241022',
    api_key_name = 'ANTHROPIC_API_KEY',
    system_prompt = helpful_prompt,
    replace = false,
  }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
end

local function anthropic_replace()
  dingllm.invoke_llm_and_stream_into_editor({
    url = 'https://api.anthropic.com/v1/messages',
    model = 'claude-3-5-sonnet-20241022',
    api_key_name = 'ANTHROPIC_API_KEY',
    system_prompt = system_prompt,
    replace = true,
  }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
end

local function openai_help()
  dingllm.invoke_llm_and_stream_into_editor({
    url = 'https://api.openai.com/v1/chat/completions',
    model = 'gpt-4o',
    api_key_name = 'OPENAI_API_KEY',
    system_prompt = helpful_prompt,
    replace = false,
  }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end


local function openai_replace()
  dingllm.invoke_llm_and_stream_into_editor({
    url = 'https://api.openai.com/v1/chat/completions',
    model = 'gpt-4o',
    api_key_name = 'OPENAI_API_KEY',
    system_prompt = system_prompt,
    replace = true,
  }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

-- map({ 'n', 'v' }, '<leader>ak', groq_replace, { desc = 'llm groq' })
-- map({ 'n', 'v' }, '<leader>aK', groq_help, { desc = 'llm groq_help' })
-- map({ 'n', 'v' }, '<leader>aL', llama405b_help, { desc = 'llm llama405b_help' })
-- map({ 'n', 'v' }, '<leader>al', llama405b_replace, { desc = 'llm llama405b_replace' })
map({ 'n', 'v' }, '<leader>aI', anthropic_help, { desc = 'llm anthropic_help' })
map({ 'n', 'v' }, '<leader>ai', anthropic_replace, { desc = 'llm anthropic' })
map({ 'n', 'v' }, '<leader>aO', openai_help, { desc = 'llm openai_help' })
map({ 'n', 'v' }, '<leader>ao', openai_replace, { desc = 'llm openai' })
-- map({ 'n', 'v' }, '<leader>ao', llama_405b_base, { desc = 'llama base' })
--
--

-- vim: ts=2 sts=2 sw=2 et
