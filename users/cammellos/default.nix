{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./home.nix
    ./pkgs/ledger.nix
    ./pkgs/network.nix
    ./pkgs/keepassxc.nix
    ./pkgs/git.nix
    ./pkgs/status
    ./pkgs/gaming.nix
    ./pkgs/clojure.nix
    ./pkgs/media.nix
    ./pkgs/alacritty.nix
    ./pkgs/rofi.nix
    ./pkgs/sway
    ./pkgs/dunst
    ./pkgs/waybar
    ./pkgs/conky
    ./pkgs/taskwarrior
    ./pkgs/development.nix
    (import ../../pkgs/tmux {
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
}
