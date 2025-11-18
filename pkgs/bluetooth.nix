{
  config,
  lib,
  ...
}:
{
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Experimental = true; # enables modern codecs and features
    };
  };
}
