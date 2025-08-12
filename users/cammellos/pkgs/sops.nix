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
        open_api_key = {
          key = "open_api_key";
          path = "%r/secrets/open_api_key";
        };
        gmailctl_config = {
          format = "binary";
          path = "${config.home-manager.users.cammellos.home.homeDirectory}/.gmailctl/config.jsonnet";
          sopsFile = ../../../secrets/cammellos/gmailctl.jsonnet;
        };
      };
    };

    home.sessionVariables = {
      OPEN_API_KEY_FILE = "$XDG_RUNTIME_DIR/sops/secrets/open_api_key";
      OPEN_API_KEY = ''$(cat /home/cammellos/.config/sops-nix/secrets/open_api_key)'';

    };
  };

}
