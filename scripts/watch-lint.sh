#!/usr/bin/env bash

find -name '*.nix' | entr -r sh -c '
  scripts/check-lint.sh
  # Capture the exit status of the Nix command
  status=$?
  if [ $status -eq 0 ]; then
    printf "All files linted successfully\n"
  fi
'
