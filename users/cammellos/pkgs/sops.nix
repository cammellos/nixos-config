{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home-manager.users.cammellos = {

    sops = {
      age.sshKeyPaths = [ "/home/cammellos/.ssh/id_sops" ];
      defaultSopsFile = ../../../secrets/cammellos/secrets.yaml;
      secrets.open_api_key = {
        key = "open_api_key";
        path = "%r/secrets/open_api_key";
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
