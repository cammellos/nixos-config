{config, pkgs, ...}:
{
  programs.adb.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cammellos" ];
  users.users.cammellos.packages = with pkgs; [
      genymotion
  ];
}
