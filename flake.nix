{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    neomutt-custom.url = "github:cammellos/neomutt?ref=feat/add-sidebar-next-wrap-option";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-kubectl.url = "github:nixos/nixpkgs/10b813040df67c4039086db0f6eaf65c536886c6";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      unstable,
      sops-nix,
      home-manager,
      nixpkgs-kubectl,
      ...
    }@inputs:
    {
      darwinConfigurations.moosel = nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        modules = [
          ./mac-os-configuration.nix
          home-manager.darwinModules.home-manager
          {
            users.users."andreamaria.piana".home = "/Users/andreamaria.piana";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

          }
          {
            nixpkgs.config.allowUnfree = true; # Set allowUnfree here
          }
        ];
        specialArgs = {
          pkgs-kubectl = import nixpkgs-kubectl {
            inherit system;
            config.allowUnfree = true;
          };
        };

      };

      nixosConfigurations.moosel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # Use modules to set configuration and overlays
        modules = [
          sops-nix.nixosModules.sops
          {
            home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
          }
          ./configuration.nix

          # Additional configurations via specialArgs
          {
            nixpkgs.config.allowUnfree = true; # Set allowUnfree here
            nixpkgs.overlays = [
              (final: prev: {
                neomutt = inputs.neomutt-custom.packages.${prev.system}.default;
              })
            ];
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
