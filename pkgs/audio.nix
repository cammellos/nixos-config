{config, pkgs, ...}:
{
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  sound.enable = true;
}
