{ config, pkgs, ... }:
{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - 0x24: ${pkgs.kitty}/bin/kitty
      # Command + S: Open Chrome or Focus & Full Screen
      cmd - s : osascript -e '
        tell application "Google Chrome"
            activate
            set frontmost to true
            if not (exists window 1) then reopen
        end tell
        tell application "System Events"
            keystroke "f" using {command down, control down}
        end tell'
    '';
  };
}
