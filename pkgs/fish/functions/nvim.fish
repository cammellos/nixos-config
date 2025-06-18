set args (for file in $argv
    realpath $file
end)
if set -q NVIM_SOCKET; and test -S $NVIM_SOCKET
  command nvim --server "$NVIM_SOCKET" --remote-tab $args
else
  command nvim $args
end
