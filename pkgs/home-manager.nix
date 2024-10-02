{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "sha256:0g1rh1vnh601la4xj0623fsbv78m097glxpvcfzljnm2yzvrap3n";
  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
