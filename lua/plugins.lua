require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "neovim/nvim-lspconfig" },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'cpp', 'c' }, -- можно добавить другие
        ignore_install = { "all" },
        highlight = {
          enable = true,              -- включить подсветку
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,              -- автодействующий отступ (не всегда идеален)
        },
        fold = {
          enable = true,
        },
      }
    end
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,
        message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%d.%m.%Y %H:%M:%S",
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          preview = { treesitter = false },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--no-ignore",
          },
          file_ignore_patterns = {
            "^.git/",
            "^build/",
            ".clangd/",
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          lsp_document_symbols = {
            symbol_width = 60,
            initial_mode = "normal",
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in current file" })
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search file names" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Search in file contents (grep)" })
      vim.keymap.set("n", "<leader>q", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search for functions in file" })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup {
        highlight = true,
        separator = " > ",
        depth_limit = 5,
      }
    end
  },
  {
    "folke/tokyonight.nvim", enabled = false
  },
  { 
	"catppuccin/nvim",
	name = "catppuccin",
    priority = 1000,
	config = function()
		require('catppuccin').setup({})

		vim.cmd.colorscheme "catppuccin-frappe"
	end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        start_in_insert = false,
        persist_mode = false,
        shade_terminals = true,
        })

        -- Храним все терминалы
        local terminals = {
        [1] = require("toggleterm.terminal").Terminal:new({ count = 1, direction = "horizontal", hidden = true }),
        [2] = require("toggleterm.terminal").Terminal:new({ count = 2, direction = "horizontal", hidden = true }),
        [3] = require("toggleterm.terminal").Terminal:new({ count = 3, direction = "horizontal", hidden = true }),
        [4] = require("toggleterm.terminal").Terminal:new({ count = 4, direction = "horizontal", hidden = true }),
        [5] = require("toggleterm.terminal").Terminal:new({ count = 5, direction = "horizontal", hidden = true }),
        [6] = require("toggleterm.terminal").Terminal:new({ count = 6, direction = "horizontal", hidden = true }),
        [7] = require("toggleterm.terminal").Terminal:new({ count = 7, direction = "horizontal", hidden = true }),
        [8] = require("toggleterm.terminal").Terminal:new({ count = 8, direction = "horizontal", hidden = true }),
        [9] = require("toggleterm.terminal").Terminal:new({ count = 9, direction = "horizontal", hidden = true }),
        }

        -- Функция: показать терминал X, скрыть остальные
        local function toggle_only(term_number)
        for i, term in pairs(terminals) do
            if i == term_number then
            term:toggle()
            else
            -- Скрываем все остальные, если они открыты
            if term:is_open() then
                term:close()
            end
            end
        end
        end

        -- Горячие клавиши
        vim.keymap.set("n", "<leader>1", function() toggle_only(1) end, { desc = "Терминал 1" })
        vim.keymap.set("n", "<leader>2", function() toggle_only(2) end, { desc = "Терминал 2" })
        vim.keymap.set("n", "<leader>3", function() toggle_only(3) end, { desc = "Терминал 3" })
        vim.keymap.set("n", "<leader>4", function() toggle_only(4) end, { desc = "Терминал 4" })
        vim.keymap.set("n", "<leader>5", function() toggle_only(5) end, { desc = "Терминал 5" })
        vim.keymap.set("n", "<leader>6", function() toggle_only(6) end, { desc = "Терминал 6" })
        vim.keymap.set("n", "<leader>7", function() toggle_only(7) end, { desc = "Терминал 7" })
        vim.keymap.set("n", "<leader>8", function() toggle_only(8) end, { desc = "Терминал 8" })
        vim.keymap.set("n", "<leader>9", function() toggle_only(9) end, { desc = "Терминал 9" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
        options = {
            theme = "catppuccin",
            icons_enabled = true,
            section_separators = { left = '', right = ''},
            component_separators = "|",
            disabled_filetypes = { "alpha", "dashboard", "neo-tree" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location", "lsp_status" },
        },
        }
    end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	},
	{
	  "startup-nvim/startup.nvim",
	  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
	  config = function()
			require("startup").setup({theme = "startify"}) 
		end
	},
	{
	  'numToStr/Comment.nvim',
	  opts = {},
	  lazy = false,
	  config = function()
		require('Comment').setup({
		  opleader = {
			line = '<leader>l',      -- визуальный режим: line comment
			block = '<leader>b',     -- визуальный режим: block comment
		  },
		})
		end
	},
	{
	  "ggandor/leap.nvim",
	  enabled = true,
	  keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
		{ "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
	  },
	  config = function(_, opts)
		local leap = require("leap")
		for k, v in pairs(opts) do
		  leap.opts[k] = v
		end
		leap.add_default_mappings(true)
		vim.keymap.del({ "x", "o" }, "x")
		vim.keymap.del({ "x", "o" }, "X")
	  end,
	},
	{
	  "folke/trouble.nvim",
	  opts = {}, 
	  cmd = "Trouble",
	  keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		  desc = "Diagnostics (Trouble)",
		},
	  },
	},
	{
	  "stevearc/aerial.nvim",
	  event = "VeryLazy",
	  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	  config = function()
		require("aerial").setup({
		  backends = { "treesitter", "lsp", "markdown" },
		  layout = { min_width = 30 },
		  show_guides = true,
		})
		-- Клавиши
		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial (symbols outline)" })
	  end,
	},
	{
	  "akinsho/bufferline.nvim",
	  version = "*",
	  dependencies = { "nvim-tree/nvim-web-devicons" },
	  config = function()
		require("bufferline").setup({
		  options = {
			diagnostics = "nvim_lsp",
			offsets = {
			  { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true }
			},
		  },
		})
		-- Клавиши
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
		vim.keymap.set("n", "<leader>bc", "<cmd>lua require('bufferline').cycle(-1)<CR><cmd>bdelete! #<CR>", { desc = "Close buffer" })

	  end,
	},
	{
	  'nvim-orgmode/orgmode',
	  event = 'VeryLazy',
	  ft = { 'org' },
	  config = function()
		require('orgmode').setup({
		  org_agenda_files = '~/org/**/*',
		  org_default_notes_file = '~/org/inbox.org',
		  org_todo_keywords = {'TODO', 'DOING', '|', 'DONE', 'REJECT'},
		  org_agenda_custom_commands = {
			c = {
			  description = 'Today agenda',
			  types = {
				{
				  type = 'tags_todo',
				  match = '+TODO="DOING"',
				  org_agenda_overriding_header = 'Active todos',
				  org_agenda_todo_ignore_scheduled = 'all',
				},
				{
				  type = 'tags_todo',
				  match = '+PRIORITY="A"',
				  org_agenda_overriding_header = 'High priority todos',
				  org_agenda_todo_ignore_deadlines = 'far',
				},
				{
				  type = 'agenda',
				  org_agenda_overriding_header = 'Daily agenda',
				  org_agenda_span = 'day'
				},
			  }
			},
		  },
		  org_capture_templates = {
			n = {
			  description = 'Note',
			  template = '* %?\n  %u',
			  target = '~/org/inbox.org'
			},
			w = {
			  description = 'Work log',
			  template = '* %?',
			  datetree = true,
			  target = '~/org/work-log.org'
			},
			t = {
			  description = 'General To-Do',
			  template = '* TODO [#B] %?\n',
			  target = '~/org/todos.org'
			},
			c = {
			  description = 'Code To-Do',
			  template = '* TODO [#B] %?\n\n%a\nProposed Solution: ',
			  target = '~/org/todos.org'
			},
			m = {
			  description = 'Meeting',
			  template = '* %? \n:Created: %T\n** Attendees\n \n** Notes\n \n** Action Items\n*** TODO [#A] ',
			  target = '~/org/meetings.org',
			  datetree = true
			}
		  }
		})
	  end,
	}
})
