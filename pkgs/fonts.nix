{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Inconsolata"
      ];
    })
  ];

  fonts.fontconfig = {
    antialias = true;
    cache32Bit = true;
    hinting.autohint = true;
    hinting.enable = true;
  };

}
