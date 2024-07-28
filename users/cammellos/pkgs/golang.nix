{config, pkgs, ...}:
{
  users.users.cammellos.packages = with pkgs; [
      go
      gopls
  ];
}
