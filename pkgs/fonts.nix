{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir.enable = true;
  };

  fonts.packages = with pkgs; [
    fira-code
    input-fonts
    fira-code-symbols
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    noto-fonts-emoji
    ubuntu_font_family
    dejavu_fonts
  ];

  fonts.fontconfig = {
    antialias = true;
    cache32Bit = true;
    hinting.autohint = true;
    hinting.enable = true;
  };

}
