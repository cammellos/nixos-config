{ config, pkgs, ...}:
{
  console.useXkbConfig = true;
  console.font = "ter-i32b";
  console.packages = with pkgs; [terminus_font];
  console.earlySetup = true;
}
