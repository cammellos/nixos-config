set parts (string split ' ' $argv[1])
if set -q NVIM_SOCKET; and test -S $NVIM_SOCKET; and test "$parts[1]" != "nvim"
  command nvim --server "$NVIM_SOCKET" --remote-expr "execute('file $argv')"
end
