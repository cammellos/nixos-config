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
    (import ../../pkgs/tmux {user = "cammellos"; config = config; pkgs = pkgs;})
    (import ../../pkgs/fish {user = "cammellos"; config = config; pkgs = pkgs;})
    ./pkgs/golang.nix
  ];
}
