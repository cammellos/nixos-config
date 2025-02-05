{ pkgs, config, user, ... }:
{
  users.users."${user}".packages = with pkgs; [ direnv ];
  home-manager.users."${user}".programs.fish.interactiveShellInit =
    "
    direnv hook fish | source
  ";
}
