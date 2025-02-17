{ config, pkgs, user, ... }:
{

  home-manager.users."${user}".home.file.".taskrc".text = ''
      data.location=${config.users.users."${user}".home}/.task
      news.version=2.6.0
  '';

  users.users."${user}".packages = with pkgs; [ taskwarrior3 ];
}
