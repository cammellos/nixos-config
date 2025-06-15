{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:1iqfq5lz3102cp3ryqqqs2hr2bdmwn0mdajprh1ls5h5nsfkigs1";
  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
