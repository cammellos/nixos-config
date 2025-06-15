{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    font-awesome
    pango
  ];

  fonts.fontconfig = {
    antialias = true;
    cache32Bit = true;
    hinting.autohint = true;
    hinting.enable = true;
  };

}
