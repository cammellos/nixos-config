{ config, pkgs, inputs, ... }:
{
  imports = [
    ./home.nix
    (import ../../pkgs/neovim {
      user = "root";
      inherit config;
      inherit pkgs;
      inherit inputs;
    })
    (import ../../pkgs/fish {
      user = "root";
      inherit config;
      inherit pkgs;
    })
  ];
}
