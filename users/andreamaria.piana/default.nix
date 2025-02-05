{ config, pkgs, ...}:
{
  users.users."andreamaria.piana".packages = with pkgs;
  [
    silver-searcher
  ];
  imports = [
    ./home.nix
    (import ../../pkgs/direnv.nix {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
    (import ../cammellos/pkgs/kitty {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
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
    ];
}
