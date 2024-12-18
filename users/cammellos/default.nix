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
    ./pkgs/kitty
    ./pkgs/rofi.nix
    ./pkgs/sway
    ./pkgs/mako.nix
    ./pkgs/waybar
    ./pkgs/conky
    ./pkgs/taskwarrior
    ./pkgs/development.nix
    ./pkgs/direnv.nix
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
