{ config, pkgs, ... }:
let
  nordRasi = pkgs.fetchFromGitHub {
    owner = "undiabler";
    repo = "nord-rofi-theme";
    rev = "master"; # Or the specific commit hash/tag you want
    sha256 = "sha256-n/3O6WdMUImCcrS5UBXoWHZevYhmC8WkA+u+ETU2m1M=";
  };
in
{
  users.users.cammellos.packages = with pkgs; [ rofi ];

  home-manager.users.cammellos = {
    home.file.".config/rofi/themes/nord.rasi".source = "${nordRasi}/nord.rasi";

    home.file.".config/rofi/config.rasi".text = ''
      configuration {
      font: "Input Mono 12";
      line-margin: 10;
      }


      @theme "~/.config/rofi/themes/nord.rasi"

      listview {
        lines: 6;
        columns: 2;
      }

      window {
        width: 60%;
      }
    '';
  };
}
