#!/usr/bin/env bash

find -name '*.nix' | entr -r sh -c '
  nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#statix -- check
  # Capture the exit status of the Nix command
  status=$?
  if [ $status -eq 0 ]; then
    printf "All files linted successfully\n"
  fi
'
