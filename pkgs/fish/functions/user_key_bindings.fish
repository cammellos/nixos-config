# Enable vi key bindings
fish_vi_key_bindings

# Define custom key bindings
function fish_user_key_bindings
  # Bind Ctrl+e to previous history item in both default and insert mode
  bind \ce history-search-backward
  bind -M insert \ce history-search-backward

  # Bind Ctrl+n to next history item in both default and insert mode
  bind \cn history-search-forward
  bind -M insert \cn history-search-forward

  # Bind Ctrl+e in insert mode to accept autosuggestion
  bind -M insert \ce accept-autosuggestion

  # Navigate left with 'y' in normal mode
  bind -M normal y backward-char
  # Navigate right with 'o' in normal mode
  bind -M normal o forward-char
  # Navigate up with 'e' in normal mode
  bind -M normal e up-line
  # Navigate down with 'n' in normal mode
  bind -M normal n down-line
end

# Call the function to apply the custom bindings
fish_user_key_bindings
