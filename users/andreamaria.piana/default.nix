{ config, pkgs, ...}:
{
  imports = [
    ./home.nix
    (import ../../pkgs/neovim {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/fish {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
}
