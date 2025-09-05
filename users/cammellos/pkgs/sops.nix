{
  config,
  pkgs,
  ...
}:
{
  users.users.cammellos.packages = with pkgs; [
    sops
  ];

  home-manager.users.cammellos = {
    sops = {
      age.sshKeyPaths = [ "${config.home-manager.users.cammellos.home.homeDirectory}/.ssh/id_ed25519" ];
      defaultSopsFile = ../../../secrets/cammellos/secrets.yaml;
      secrets = {
        tidal_client_id = {
          key = "tidal_client_id";
          path = "%r/secrets/tidal_client_id";
        };
        tidal_client_secret = {
          key = "tidal_client_secret";
          path = "%r/secrets/tidal_client_secret";
        };
        openai_api_key = {
          key = "openai_api_key";
          path = "%r/secrets/openai_api_key";
        };
        gmailctl_config = {
          format = "binary";
          path = "${config.home-manager.users.cammellos.home.homeDirectory}/.gmailctl/config.jsonnet";
          sopsFile = ../../../secrets/cammellos/gmailctl.jsonnet;
        };
      };
    };

    home.sessionVariables = {
      OPENAI_API_KEY_FILE = "$XDG_RUNTIME_DIR/sops/secrets/openai_api_key";
      OPENAI_API_KEY = ''$(cat /home/cammellos/.config/sops-nix/secrets/openai_api_key)'';
      TIDAL_CLIENT_ID = ''$(cat /home/cammellos/.config/sops-nix/secrets/tidal_client_id)'';
      TIDAL_CLIENT_SECRET = ''$(cat /home/cammellos/.config/sops-nix/secrets/tidal_client_secret)'';
    };
  };

}
