#!/usr/bin/env bash

find -name '*.nix' | xargs  nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#nixfmt-rfc-style
