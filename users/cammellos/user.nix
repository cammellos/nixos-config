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
      leiningen
      clj-kondo
      gnumake
      unzip
      ack
      xclip # for nvim copy to clipboard
      vlc
      todoist
      gitg
      arandr
      gnupg
      nodejs_20
      go
      gcc
      chromium
      sakura
      spotify
      keepassxc
      dropbox
      feh
      libnotify
      rofi
      lutris
      wine64
      genymotion
    ];
  };
}
