if test (count $argv) -eq 0
  command tmux new-session -s (echo %self)(tty)
else
  command tmux $argv
end
