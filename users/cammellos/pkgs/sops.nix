{
  config,
  ...
}:
{
  home-manager.users.cammellos = {
    sops = {
      age.sshKeyPaths = [ "${config.home-manager.users.cammellos.home.homeDirectory}/.ssh/id_sops" ];
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
    };
  };

  environment.variables = {
    OPEN_API_KEY = ''
      $(cat ${toString (builtins.getEnv "XDG_RUNTIME_DIR")}/secrets/open_api_key)
    '';
  };
}
