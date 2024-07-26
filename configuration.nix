{ config, pkgs, ...}:

{

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./boot.nix
      ./networking/shared.nix
      ./networking/host.nix
      ./modules/home-manager.nix
      ./users/cammellos
    ];

  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;
hardware.pulseaudio.support32Bit = true;

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
    xkb.layout = "us";
    xkb.variant = "workman";
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  console.useXkbConfig = true;

  virtualisation.docker.enable = true;

  # programs
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
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
      nssmdns4 = true;
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
