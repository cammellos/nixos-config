if set -q NVIM_SOCKET; and test -S $NVIM_SOCKET
  command nvim --server "$NVIM_SOCKET" --remote-expr "execute('file terminal')"
end
