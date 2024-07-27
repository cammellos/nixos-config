{config, pkgs, ...}:
{
  home-manager.users.cammellos.programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    extraConfig = builtins.readFile ./config/tmux.conf;
  };
}
