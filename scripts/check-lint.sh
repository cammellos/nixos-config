#!/usr/bin/env bash

nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#statix -- check
