{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    (import ../../pkgs/tmux {user = "root"; config = config; pkgs = pkgs;})
  ];
}
