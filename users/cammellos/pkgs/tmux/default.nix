{ config, pkgs, ... }:
{
  home-manager.users.cammellos.home.file.".local/bin/tmux-window-handler.sh".source =
    ./config/tmux-window-handler.sh;
}
