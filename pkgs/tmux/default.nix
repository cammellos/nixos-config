{config, pkgs, user, ...}:
{
  home-manager.users.${user}.programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    extraConfig = builtins.readFile ./config/tmux.conf;
  };
}
