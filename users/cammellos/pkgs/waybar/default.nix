{ config, pkgs, ... }:
let
  mediaplayer = pkgs.callPackage ./scripts/mediaplayer.nix { };
in
{
  home-manager.users.cammellos.home = {
    packages = with pkgs; [
      mediaplayer
      jetbrains-mono
    ];
    file.".config/waybar/style.css".text = builtins.readFile ./style/style.css;
  };

  home-manager.users.cammellos.programs.waybar = {
    enable = true;
    settings.mainBar = {
      id = "bar-0";
      ipc = true;
      position = "top";
      layer = "top";
      height = 20;
      spacing = 6;
      modules-left = [ "sway/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "cpu"
        "temperature"
        "memory"
        "battery"
      ];
      clock = {
        format = "<span>[]</span> {:%a %d %b %H:%M}";
      };
      temperature = {
        tooltip = false;
        thermal-zone = 2;
        hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
        critical-threshold = 80;
        format = "<span>[󱃃]</span> {temperatureC}°C";
        format-critical = "<span>[󰔐]</span> {temperatureC}°C";
      };

      tray = {
        icon-size = 18;
        spacing = 12;
      };

      battery = {
        bat = "BAT1";
        interval = 1;
        states = {
          good = 99;
          warning = 30;
          critical = 2;
        };
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        format = "<span>[{icon}]</span> {capacity}%";
        format-critical = "<span>[{icon}]</span> {capacity}%!!";
        format-warning = "<span>[{icon}]</span> {capacity}%";
        format-full = "<span>[{icon}]</span> {capacity}%";
        format-charging = "<span>[󰂅]</span> {capacity}%";
        format-charging-warning = "<span>[󰢝]</span> {capacity}%";
        format-charging-critical = "<span>[󰢜]</span> {capacity}%";
        format-plugged = "<span>[󰂅]</span> {capacity}%";
        format-alt = "<span>[󱧥]</span> {time}";
        tooltip = false;
      };

      memory = {
        interval = 1;
        format = "<span>[]</span> {percentage}%";
        states = {
          warning = 85;
        };
      };

      "sway/workspaces" = {
        format = "{icon}";
        active-only = false;
        format-icons = {
          "0:a" = "<span></span>";
          "1:s" = "<span></span>";
          "2:h" = "<span>󰰁</span>";
          "3:t" = "<span>󰰥</span>";
          "4:g" = "<span></span>";
          "5:y" = "<span></span>";
          "6:e" = "<span>󰯸</span>";
          "7:e" = "<span>󰯸</span>";
          "8:o" = "<span>󰰖</span>";
          "9:i" = "<span>󰽯</span>";
        };
        window-format = "{name}";
      };

      cpu = {
        format = "<span>[]</span> {usage}%";
        tooltip = false;
        interval = 1;
      };
    };
  };
}
