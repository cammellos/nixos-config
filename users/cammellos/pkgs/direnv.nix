{ pkgs, config, ... }:
{
  users.users.cammellos.packages = with pkgs; [ direnv ];
  home-manager.users.cammellos.programs.fish.interactiveShellInit = "
    direnv hook fish | source
  ";
}
