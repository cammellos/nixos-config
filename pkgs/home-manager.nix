{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:18ddqcn0dv43lbqm39dvff9c4vkb54ygs2rp6vfxamcxhdqka5k9";

  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
