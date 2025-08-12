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
  home-manager.users.cammellos = {
    sops.secrets = {
      remote_partners_base_url = {
        key = "partners_base_url";
        path = "%r/secrets/remote/envs/partners/open_api_key";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      remote_partners_client_id = {
        key = "partners_client_id";
        path = "%r/secrets/remote/envs/partners/client_id";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      remote_partners_client_secret = {
        key = "partners_client_secret";
        path = "%r/secrets/remote/envs/partners/client_secret";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      remote_staging_base_url = {
        key = "staging_base_url";
        path = "%r/secrets/remote/envs/staging/open_api_key";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      remote_staging_client_id = {
        key = "staging_client_id";
        path = "%r/secrets/remote/envs/staging/client_id";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      remote_staging_client_secret = {
        key = "staging_client_secret";
        path = "%r/secrets/remote/envs/staging/client_secret";
        sopsFile = ../../../secrets/cammellos/remote/secrets.yml;
      };
      tparners = {
        format = "binary";
        mode = "0555";
        path = "${config.home-manager.users.cammellos.home.homeDirectory}/.local/bin/tpartners.sh";
        sopsFile = ../../../secrets/cammellos/remote/tpartners.sh;

      };
      tprod = {
        format = "binary";
        mode = "0555";
        path = "${config.home-manager.users.cammellos.home.homeDirectory}/.local/bin/tprod.sh";
        sopsFile = ../../../secrets/cammellos/remote/tprod.sh;
      };
      tstaging = {
        format = "binary";
        mode = "0555";
        path = "${config.home-manager.users.cammellos.home.homeDirectory}/.local/bin/tstaging.sh";
        sopsFile = ../../../secrets/cammellos/remote/tstaging.sh;
      };
      tsand = {
        format = "binary";
        mode = "0555";
        path = "${config.home-manager.users.cammellos.home.homeDirectory}/.local/bin/tsand.sh";
        sopsFile = ../../../secrets/cammellos/remote/tsand.sh;
      };
      docker = {
        format = "binary";
        mode = "0555";
        path = "${config.home-manager.users.cammellos.home.homeDirectory}/.docker/config.json";
        sopsFile = ../../../secrets/cammellos/remote/docker-config;
      };
    };
    home.sessionVariables = {
      REMOTE_PARTNERS_BASE_URL = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_partners_base_url)'';
      REMOTE_PARTNERS_CLIENT_ID = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_partners_client_id)'';
      REMOTE_PARTNERS_CLIENT_SECRET = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_partners_client_secret)'';
      REMOTE_STAGING_BASE_URL = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_staging_base_url)'';
      REMOTE_STAGING_CLIENT_ID = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_staging_client_id)'';
      REMOTE_STAGING_CLIENT_SECRET = ''$(cat /home/cammellos/.config/sops-nix/secrets/remote_staging_client_secret)'';
    };
  };

  users.users.cammellos.packages = with pkgs; [
    awscli2
    amazon-ecr-credential-helper
    kubectl
    _1password
    _1password-gui
  ];
}
