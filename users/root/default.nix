{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    (import ../../pkgs/tmux {user = "root"; config = config; pkgs = pkgs;})
    (import ../../pkgs/fish {user = "root"; config = config; pkgs = pkgs;})
  ];
}
