{ config, pkgs, ... }:
{
  users.users.cammellos = {
    isNormalUser = true;
    description = "cammellos";
    extraGroups = [
      "networkmanager"
      "input"
      "wheel"
      "audio"
      "adbusers"
      "docker"
      "plugdev"
    ];
    packages = with pkgs; [ gnupg ];
  };
}
