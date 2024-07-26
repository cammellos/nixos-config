# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  custom_pkgs = self: super: {

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
      in self.runCommand "uhk-agent" {} ''
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

      neovim = import ./vim.nix { pkgs = super; };
  };

in {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nixpkgs.overlays = [
    custom_pkgs
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;
hardware.pulseaudio.support32Bit = true;
  networking.hostName = "moosel"; # Define your hostname.
  networking.useDHCP = true;
  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    interfaces = ["wlp1s0"];
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.udev.packages = with pkgs; [ pkgs.yubikey-personalization uhk-agent ];
      programs.gnupg.agent = {
  	enable = true;
	enableSSHSupport = true;

  };

  services.blueman.enable = true;


  # Configure keymap in X11
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    xkbVariant = "workman";
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  console.useXkbConfig = true;

users.groups.plugdev = {};

  # Required for Ledger Live to detect Ledger Nano S via USB
  services.udev.extraRules = ''
  # firmware 1.6.0+
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="2b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="3b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="4b7c", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1807", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1808", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="1011", MODE="0660", GROUP="plugdev"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="1015", MODE="0660", GROUP="plugdev"

  SUBSYSTEM=="usb", ATTR{idVendor}=="22d9", ATTR{idProduct}=="2765", MODE="0666", GROUP="plugdev"



  ''
  ;


  virtualisation.docker.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cammellos = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "cammellos";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" "docker" "plugdev"];
    packages = with pkgs; [
      networkmanagerapplet
      silver-searcher
      openvpn
      gh
      dunst
      leiningen
      clj-kondo
      ledger-live-desktop
      gnumake
      unzip
      ack
      xclip # for nvim copy to clipboard
      vlc
      todoist
      gitg
      arandr
      gnupg
      nodejs_20
      go
      gcc
     chromium
     sakura
     spotify
     keepassxc
     dropbox
     feh
     libnotify
     rofi
     lutris
     wine64
     genymotion
    ];
  };
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cammellos" ];

  # programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.git = {
    enable = true;
  };
  programs.fish.enable = true;

  programs.adb.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  services.xserver.dpi = 180;
  console.font = "ter-i32b";
  console.packages = with pkgs; [terminus_font];
  console.earlySetup = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     tmux
     uhk-agent
     fish
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


sound.enable = true;


services = {
    avahi = {
    openFirewall = true;
      enable = true;
      nssmdns = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-brother-hl1210w
      ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
