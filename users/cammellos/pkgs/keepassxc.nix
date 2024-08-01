{ config, pkgs, ... }:
{
  users.users.cammellos = {
    packages = with pkgs; [
      keepassxc
      dropbox
    ];
  };
}
