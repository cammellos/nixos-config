{config, pkgs, ...}:
{
  users.users.cammellos.packages = with pkgs; [
      sakura
    ];
  home-manager.users.cammellos.home.file = {
    ".config/sakura/sakura.conf".text = builtins.readFile ./config/sakura.conf;
  };
}
