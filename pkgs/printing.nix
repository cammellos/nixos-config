{ config, pkgs, ...}:
{
  services = {
    avahi = {
      openFirewall = true;
      enable = true;
      nssmdns4 = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-brother-hl1210w
      ];
    };
  };
}
