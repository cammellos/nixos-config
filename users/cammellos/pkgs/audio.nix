{
  config,
  pkgs,
  inputs,
  ...
}:
{
  users.users.cammellos.packages = with pkgs; [
    pasystray
    playerctl
    pavucontrol
    inputs.tidaLuna.packages.${system}.default
  ];
}
