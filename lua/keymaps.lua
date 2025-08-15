-- Открыть дерево файлов
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Открыть новый таб
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })

-- Переключение между табами
vim.keymap.set("n", "<leader>]", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>[", ":tabprevious<CR>", { desc = "Previous tab" })

-- Закрыть текущий таб
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set('v', "<leader>k", function()
  vim.lsp.buf.format({ range = true })
end, { desc = "Format selected code" })

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set("n", "<leader>ps", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({ search = word, initial_mode = "normal" })
end, { desc = "Grep word under cursor" })

vim.keymap.set('n', '<leader>j', vim.diagnostic.open_float)

-- Не копируем старый текст после вставки нового в Visual режиме
vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })

-- Хак для использования Esc в lazygit
local group = vim.api.nvim_create_augroup("LazygitMods", { clear = true })
vim.api.nvim_create_autocmd("TermEnter", {
	pattern = "*",
	group = group,
	callback = function()
		local name = vim.api.nvim_buf_get_name(0)
		if string.find(name, "lazygit") then
			vim.keymap.set("t", "<ESC>",
				function()
					-- Get the terminal job ID for the current buffer
					local bufnr = vim.api.nvim_get_current_buf()
					local chan = vim.b[bufnr].terminal_job_id
					if chan then
						-- Send the ESC key sequence to the terminal
						-- "\x1b" is the escape character
						vim.api.nvim_chan_send(chan, "\x1b")
					end
				end,
				{ buffer = true })
			return
		end
	end,
})

local telescope = require('telescope.builtin')

local function live_grep_with_filter()
  vim.ui.input({prompt = 'Паттерн для поиска (например, src/**/*.cpp): '}, function(input)
    if input == nil or input == '' then
      print("Отмена поиска")
      return
    end
    telescope.live_grep({
      glob_pattern = { input },
    })
  end)
end

vim.keymap.set('n', '<leader>k', live_grep_with_filter, { desc = 'Live grep с фильтром по паттерну' })

vim.keymap.set('n', '<leader>z', function()
  require('telescope.builtin').buffers({
    initial_mode = "normal"
  })
end, { desc = 'Find Buffers (Normal mode)' })

