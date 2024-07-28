{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./home.nix
    ./pkgs/ledger.nix
    ./pkgs/git.nix
    ./pkgs/status
    ./pkgs/gaming.nix
    ./pkgs/clojure.nix
    ./pkgs/media.nix
    ./pkgs/alacritty.nix
    ./pkgs/development.nix
    (import ../../pkgs/tmux {user = "cammellos"; inherit config; inherit pkgs;})
    (import ../../pkgs/fish {user = "cammellos"; inherit config; inherit pkgs;})
    ./pkgs/golang.nix
  ];
}
