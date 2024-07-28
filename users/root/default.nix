{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    (import ../../pkgs/tmux {user = "root"; inherit config; inherit pkgs;})
    (import ../../pkgs/fish {user = "root"; inherit config; inherit pkgs;})
  ];
}
