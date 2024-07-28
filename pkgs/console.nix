{ config, pkgs, ...}:
{
  console = {
    useXkbConfig = true;
    font = "ter-i32b";
    packages = with pkgs; [terminus_font];
    earlySetup = true;
  };
}
