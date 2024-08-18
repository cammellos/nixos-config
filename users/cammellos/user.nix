{ config, pkgs, ... }:
{
  users.users.cammellos = {
    isNormalUser = true;
    description = "cammellos";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "adbusers"
      "docker"
      "plugdev"
    ];
    packages = with pkgs; [ gnupg ];
  };
}
