{ config, pkgs, ...}:
{
  fonts.packages = with pkgs; [
    fira-code
    input-fonts
    fira-code-symbols
  ];
}
