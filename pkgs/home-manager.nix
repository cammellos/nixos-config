{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "sha256:1vlfxqma4g20vffn2ysw1jwd7kwhyc655765dz6af6k15392gg7p";
  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
