{ config, pkgs, ... }:
{
  home-manager.users.cammellos.home.file.".config/waybar/style.css".text = builtins.readFile ./style/style.css;
  home-manager.users.cammellos.programs.waybar = {
    enable = true;
    settings.mainBar = {
      id = "bar-0";
      ipc = true;
      position = "top";
      layer = "top";
      height = 30;
      modules-left = [ "sway/workspaces" ];
      modules-right = [
        "temperature"
        "memory"
        "cpu"
        "clock"
        "battery"
        "tray"
      ];
      clock = {
        format = "  {:%H:%M} ";
      };
      temperature = {
        critical-threshold = 80;
        tooltip = false;
        format = " {temperatureC}°C";
      };
      battery = {
        bat = "BAT1";
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        max-length = 25;
      };
      memory = {
        interval = 1;
        format = "󰍛 {percentage}%";
        states = {
          warning = 85;
        };
      };
      cpu = {
        interval = 1;
        format = "󰻠 {usage}%";
        states = {
          warning = 75;
        };
      };
    };
  };
}
