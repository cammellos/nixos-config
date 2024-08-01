{ config, pkgs, ... }:
{
  users.users.cammellos = {
    isNormalUser = true;
    shell = pkgs.fish;
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
