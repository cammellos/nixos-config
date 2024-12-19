{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
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
