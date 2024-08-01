# Enable vi key bindings
fish_vi_key_bindings

# Define custom key bindings
function fish_user_key_bindings
  # Bind Ctrl+e to previous history item in both default and insert mode
  bind \cn history-search-forward
  bind -M insert \cn history-search-forward
  bind \ce history-search-backward
  bind -M insert \ce history-search-backward

  # Bind Ctrl+n to next history item in both default and insert mode

  # Bind Ctrl+e in insert mode to accept autosuggestion
  bind -M insert \co accept-autosuggestion

  # Navigate left with 'y' in normal mode
  bind -M default y backward-char
  # Navigate right with 'o' in normal mode
  bind -M default o forward-char
  # Navigate up with 'e' in normal mode
  bind -M default e up-line
  # Navigate down with 'n' in normal mode
  bind -M default n down-line

  bind -M visual y backward-char
  bind -M visual o forward-char
  bind -M visual e up-line
  # Navigate down with 'n' in normal mode
  bind -M visual n down-line

  bind -M visual -m default h 'commandline -s | wl-copy; commandline -f end-selection repaint-mode'


  # Bind 'uu' to escape to normal mode
  bind -M insert --sets-mode default uu repaint

end

# Call the function to apply the custom bindings
fish_user_key_bindings
