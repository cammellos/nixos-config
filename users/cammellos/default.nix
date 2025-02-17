{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./home.nix
    ./pkgs/audio.nix
    ./pkgs/obs.nix
    ./pkgs/android.nix
    ./pkgs/ledger.nix
    ./pkgs/network.nix
    ./pkgs/keepassxc.nix
    ./pkgs/git.nix
    ./pkgs/gaming.nix
    ./pkgs/social.nix
    ./pkgs/clojure.nix
    ./pkgs/media.nix
    (import ./pkgs/kitty {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    ./pkgs/rofi.nix
    ./pkgs/sway
    ./pkgs/mako.nix
    ./pkgs/waybar
    ./pkgs/conky
    (import ../../pkgs/taskwarrior {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    ./pkgs/development.nix
    (import ../../pkgs/elixir.nix {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/direnv.nix {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/neovim {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    (import ../../pkgs/fish {
      user = "cammellos";
      inherit config;
      inherit pkgs;
    })
    ./pkgs/golang.nix
  ];
  environment.localBinInPath = true;
}
