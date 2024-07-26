{config, pkgs, ...}:
{
  programs.adb.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cammellos" ];
  users.users.cammellos.packages = with pkgs; [
      genymotion
  ];

  home-manager.users.cammellos.home.file = {
        ".local/bin" = {
            source = ./scripts;
            recursive = true;
        };
        ".config/nix-shells" = {
          source = ./shells;
          recursive = true;
        };
    };
}
