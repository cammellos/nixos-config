{config, pkgs, ...}:
{
  users.users.cammellos = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "cammellos";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" "docker" "plugdev"];
    packages = with pkgs; [
      networkmanagerapplet
      silver-searcher
      openvpn
      gh
      dunst
      gnumake
      unzip
      ack
      xclip # for nvim copy to clipboard
      todoist
      arandr
      gnupg
      gcc
      keepassxc
      dropbox
      feh
      libnotify
      rofi
    ];
  };
}
