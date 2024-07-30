{ config, pkgs, ... }:
{
  console = {
    keyMap = ./keymaps/workman-p.kmap;
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };
}
