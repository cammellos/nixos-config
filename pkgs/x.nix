{ config, pkgs, ... }:
{
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    autorun = true;
    dpi = 180;
    xkb.layout = "us";
    xkb.variant = "workman";
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };
}
