{
  config,
  pkgs,
  pkgs-kubectl,
  ...
}:
{
  users.users."andreamaria.piana".packages = [
    pkgs-kubectl.kubectl
    pkgs.silver-searcher
    pkgs.awscli2
    pkgs.postman
  ];
  imports = [
    ./remotectl.nix
    ./keyboard.nix
    ./home.nix
    (import ../../pkgs/taskwarrior {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/tmux {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/elixir.nix {
      user = "andreamaria.piana";
      inherit config;
      inherit pkgs;
    })
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
