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

  -- Tabs with terminal
  vim.keymap.set('n', ',d', ':tabnew | terminal<CR>', opts)
  vim.keymap.set('i', ',d', '<Esc>:tabnew | terminal<CR>', opts)
  vim.keymap.set('t', ',d', '<C-\\><C-N>:tabnew | terminal<CR>', opts)

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

  vim.keymap.set('v', 'E', function()
    -- Yank selection into the "v register
    vim.cmd('normal! "vy')

    -- Get yanked text and clean it up
    local text = vim.fn.getreg('v'):gsub("^%s+", ""):gsub("%s+$", "")

    if text == "" then
      vim.notify("❌ Nothing was yanked. Make sure you selected text.", vim.log.levels.WARN)
      return
    end

    -- Build the string to type: a → insert mode, then the command, then Enter (CR), then ESC
    local cmd = "a" .. "nvim " .. text .. "\r" .. "\027"  -- \r = Enter, \027 = ESC

    -- Feed the keys into Neovim
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Insert and execute 'nvim <selection>'", silent = true })

  vim.keymap.set('v', 'T', function()
    -- Yank selection into the "v register
    vim.cmd('normal! "vy')

    -- Get yanked text and clean it up
    local text = vim.fn.getreg('v'):gsub("^%s+", ""):gsub("%s+$", "")

    if text == "" then
      vim.notify("❌ Nothing was yanked. Make sure you selected text.", vim.log.levels.WARN)
      return
    end

    local ext = text:match("([^.]+)$")
    local base

    if ext == "exs" or ext == "ex" then
      base = "mix test.watch "
    elseif ext == "py" then
      base = "pytest -k "
    elseif ext == "js" or ext == "ts" then
      base = "npm test -- "
    else
      vim.notify("❌ No default command for *." .. ext, vim.log.levels.WARN)
      return
    end

    -- Build the string to type: a → insert mode, then the command, then Enter (CR), then ESC
    local cmd = "a" .. base .. text .. " | tee /tmp/output.txt" .. "\r" .. "\027"  -- \r = Enter, \027 = ESC

    -- Feed the keys into Neovim
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Insert and execute 'nvim <selection>'", silent = true })

end

WorkmanKeyboard()
