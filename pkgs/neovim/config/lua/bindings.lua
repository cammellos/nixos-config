vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true, silent = false})
vim.api.nvim_set_keymap('i', 'uu', '<Esc>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', 'UUUU', '<Nop>', { noremap = true, silent = true })

-- Define the Keyboard function
local function WorkmanKeyboard()
  -- Visual mode remappings
  vim.api.nvim_set_keymap('v', 'l', 'o', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'o', 'l', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'L', 'O', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'O', 'L', { noremap = true, silent = true })

  -- Search (N)ext -> (J)ump
  vim.api.nvim_set_keymap('v', 'j', 'n', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'n', 'j', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'J', 'N', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'N', 'J', { noremap = true, silent = true })

  -- (E)nd of word -> brea(K) of word
  vim.api.nvim_set_keymap('v', 'k', 'e', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'e', 'k', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'K', 'E', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'E', '', { noremap = true, silent = true })

  -- Yank to Haul
  vim.api.nvim_set_keymap('v', 'h', 'y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('o', 'h', 'y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'y', 'h', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'H', 'Y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', 'Y', 'H', { noremap = true, silent = true })

  -- Normal mode remappings
  vim.api.nvim_set_keymap('n', 'l', 'o', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'o', 'l', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'L', 'O', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'O', 'L', { noremap = true, silent = true })

  -- Search (N)ext -> (J)ump
  vim.api.nvim_set_keymap('n', 'j', 'n', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'n', 'j', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'J', 'N', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'N', 'J', { noremap = true, silent = true })

  -- (E)nd of word -> brea(K) of word
  vim.api.nvim_set_keymap('n', 'k', 'e', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'e', 'k', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'K', 'E', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'E', '', { noremap = true, silent = true })

  -- Yank to Haul
  vim.api.nvim_set_keymap('n', 'y', 'h', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'H', 'Y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'Y', 'H', { noremap = true, silent = true })

  -- Split mapping
  vim.api.nvim_set_keymap('n', ',a', '<C-w>v', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',r', '<C-w>k', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',h', '<C-w>j', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',r', '<C-w>l', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',d', '<C-w>h', { noremap = true, silent = true })

  -- Tab remapping
  vim.api.nvim_set_keymap('n', ',w', ':tabnew<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',g', ':tabnext<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',t', ':tabprevious<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ',1', ':Neomake<CR>', { noremap = true, silent = true })

  -- terminal
  vim.api.nvim_set_keymap('n', ',s', ':term<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('t', 'uu', [[<C-\><C-n>]], { noremap = true, silent = true })
end

WorkmanKeyboard()
