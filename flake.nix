{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { self, nix-darwin, nixpkgs, home-manager, ... }@inputs:
    {
      darwinConfigurations.moosel = nix-darwin.lib.darwinSystem {
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
      };
    };
}
