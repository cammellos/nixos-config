{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    (import ../../pkgs/tmux {user = "root"; config = config; pkgs = pkgs;})
    (import ../../pkgs/fish.nix {user = "root"; config = config; pkgs = pkgs;})
  ];
}
