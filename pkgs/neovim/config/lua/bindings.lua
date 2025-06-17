local opts = { noremap = true, silent = true }

-- Top-level keymaps
vim.keymap.set('n', ';', ':', { noremap = true, silent = false })
vim.keymap.set('n', ':', ';', { noremap = true, silent = false })
vim.keymap.set('i', 'uu', '<Esc>', { noremap = true, silent = false })
vim.keymap.set('i', 'UUUU', '<Nop>', opts)

-- Define the Keyboard function
local function WorkmanKeyboard()
  -- Visual mode remappings
  vim.keymap.set('v', 'l', 'o', opts)
  vim.keymap.set('v', 'o', 'l', opts)
  vim.keymap.set('v', 'L', 'O', opts)
  vim.keymap.set('v', 'O', 'L', opts)

  vim.keymap.set('v', 'j', 'n', opts)
  vim.keymap.set('v', 'n', 'j', opts)
  vim.keymap.set('v', 'J', 'N', opts)
  vim.keymap.set('v', 'N', 'J', opts)

  vim.keymap.set('v', 'k', 'e', opts)
  vim.keymap.set('v', 'e', 'k', opts)
  vim.keymap.set('v', 'K', 'E', opts)
  vim.keymap.set('v', 'E', '', opts)

  vim.keymap.set('v', 'h', 'y', opts)
  vim.keymap.set('v', 'y', 'h', opts)
  vim.keymap.set('v', 'H', 'Y', opts)
  vim.keymap.set('v', 'Y', 'H', opts)
  vim.keymap.set('o', 'h', 'y', opts)

  -- Normal mode remappings
  vim.keymap.set('n', 'l', 'o', opts)
  vim.keymap.set('n', 'o', 'l', opts)
  vim.keymap.set('n', 'L', 'O', opts)
  vim.keymap.set('n', 'O', 'L', opts)

  vim.keymap.set('n', 'j', 'n', opts)
  vim.keymap.set('n', 'n', 'j', opts)
  vim.keymap.set('n', 'J', 'N', opts)
  vim.keymap.set('n', 'N', 'J', opts)

  vim.keymap.set('n', 'k', 'e', opts)
  vim.keymap.set('n', 'e', 'k', opts)
  vim.keymap.set('n', 'K', 'E', opts)
  vim.keymap.set('n', 'E', '', opts)

  vim.keymap.set('n', 'y', 'h', opts)
  vim.keymap.set('n', 'H', 'Y', opts)
  vim.keymap.set('n', 'Y', 'H', opts)

  -- Window splits
  vim.keymap.set('n', ',a', '<C-w>v', opts)
  vim.keymap.set('n', ',d', '<C-w>h', opts)
  vim.keymap.set('n', ',r', '<C-w>l', opts)

  -- Tabs
  vim.keymap.set('n', ',t', ':tabnew<CR>', opts)
  vim.keymap.set('i', ',t', '<Esc>:tabnew<CR>', opts)
  vim.keymap.set('t', ',t', '<C-\\><C-N>:tabnew<CR><C-\\><C-N>', opts)

  -- Tab navigation
  vim.keymap.set({ 'n', 'i', 't' }, ',o', function()
    vim.cmd('tabnext')
    if vim.bo.buftype == 'terminal' then
      vim.cmd('startinsert')
    end
  end, opts)

  vim.keymap.set({ 'n', 'i', 't' }, ',y', function()
    vim.cmd('tabprevious')
    if vim.bo.buftype == 'terminal' then
      vim.cmd('startinsert')
    end
  end, opts)

  -- Terminal: open terminal
  vim.keymap.set('n', ',s', ':term<CR>', opts)

  -- Escape from terminal mode
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
end

WorkmanKeyboard()
