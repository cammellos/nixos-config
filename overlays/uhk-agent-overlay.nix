{ self, super, ... }:
{
  uhk-agent =
    let
      version = "3.1.0";
      image = self.stdenv.mkDerivation {
        name = "uhk-agent-image";
        src = self.fetchurl {
          url = "https://github.com/UltimateHackingKeyboard/agent/releases/download/v${version}/UHK.Agent-${version}-linux-x86_64.AppImage";
          sha256 = "sha256-KFuB1cbrEDfqeRyrhXZs4ClhdIjZqIT5a+rnvdi3kpA=";
        };
        buildCommand = ''
          mkdir -p $out
          cp $src $out/appimage
          chmod ugo+rx $out/appimage
        '';
      };
    in
    self.runCommand "uhk-agent" { } ''
      mkdir -p $out/bin $out/etc/udev/rules.d
      echo "${self.appimage-run}/bin/appimage-run ${image}/appimage" > $out/bin/uhk-agent
      chmod +x $out/bin/uhk-agent
      cat > $out/etc/udev/rules.d/50-uhk60.rules <<EOF
      # Ultimate Hacking Keyboard rules
      # These are the udev rules for accessing the USB interfaces of the UHK as non-root users.
      # Copy this file to /etc/udev/rules.d and physically reconnect the UHK afterwards.
      SUBSYSTEM=="input", GROUP="input", MODE="0666"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", MODE:="0666", GROUP="plugdev"
      KERNEL=="hidraw*", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", MODE="0666", GROUP="plugdev"
      EOF
    '';
}
