{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    leiningen
    clj-kondo
  ];
}
