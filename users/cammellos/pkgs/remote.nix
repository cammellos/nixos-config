{ config, pkgs, ... }:
{
  imports = [
    (import ../../../pkgs/remotectl.nix {
      user = "cammellos";
      inherit config;
      inherit pkgs;
      sha256 = "sha256-NFk5nbnCE6gXxdFbibrSH7v6alzMb9MBXpueNTeffe8=";
      os = "linux";
      arch = "amd64";
    })
  ];
  home-manager.users.cammellos.sops.secrets.tparners = {
    format = "binary";
    mode = "0555";
    path = "${config.home-manager.users.cammellos.home.homeDirectory}/.local/bin/tpartners.sh";
    sopsFile = ../../../secrets/cammellos/remote/tpartners.sh;

  };

  users.users.cammellos.packages = with pkgs; [
    awscli2
    kubectl
    _1password
    _1password-gui
  ];
}
