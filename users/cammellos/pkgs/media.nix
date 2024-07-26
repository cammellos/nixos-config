{config, pkgs, ...}:
{
  users.users.cammellos.packages = with pkgs; [
    chromium
    spotify
    vlc
  ];
}
