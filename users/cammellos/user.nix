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
    packages = with pkgs; [
      networkmanagerapplet
      wl-clipboard
      openvpn
      dunst
      xclip # for nvim copy to clipboard
      todoist
      arandr
      gnupg
      keepassxc
      dropbox
      feh
      libnotify
    ];
  };
}
