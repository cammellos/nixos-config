{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

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
            nixpkgs.overlays = [
              (import ./pkgs/neovim/kitty-scrollback.nix)
            ];
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
          ./configuration.nix

          # Additional configurations via specialArgs
          {
            nixpkgs.config.allowUnfree = true; # Set allowUnfree here
            nixpkgs.overlays = [
              (import ./pkgs/neovim/kitty-scrollback.nix)
            ];
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
