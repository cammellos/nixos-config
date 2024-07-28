{config, pkgs, ...}:
{
  users.users.cammellos.packages = with pkgs; [
    entr
    silver-searcher
    gh
    gnumake
    unzip
    gcc
  ];
}
