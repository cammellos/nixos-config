{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "sha256:026rvynmzmpigax9f8gy9z67lsl6dhzv2p6s8wz4w06v3gjvspm1";
  };
in
{
  imports = [ (import "${home-manager}/nixos") ];
}
