{config, pkgs, user, ...}:
{
  programs.tmux.enable = true;
  environment.systemPackages = with pkgs; [
    tmux
  ];

  home-manager.users.${user}.programs.tmux = {
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.nord;
        extraConfig = ''set -g @plugin "nordtheme/tmux"'';
      }
    ];
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    extraConfig = builtins.readFile ./config/tmux.conf;
  };
}
