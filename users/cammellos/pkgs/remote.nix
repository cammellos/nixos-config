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

  users.users.cammellos.packages = with pkgs; [
    awscli2
    kubectl
    _1password
    _1password-gui
  ];
}
