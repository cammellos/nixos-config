{
  config,
  pkgs,
  ...
}:
{
  users.users.cammellos.packages = with pkgs; [
    pasystray
    playerctl
    pavucontrol
  ];
}
