{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    babashka
  ];
}
