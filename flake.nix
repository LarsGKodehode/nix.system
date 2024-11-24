{
  description = "My systems";

  inputs = {
    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Used for MacOS system config
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for dynamic user files
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
    }@inputs:
    let
      # Global configuration sourced by other files
      globals =
        let
          baseName = "larsgunnar.no";
        in
        rec {
          user = "zab";
          gitName = "LarsGKodehode";
          gitEmail = "104063134+LarsGKodehode@users.noreply.github.com";
        };

      # Modifications to the declared inputs
      overlays = [ ];

      # Systems supported
      supportedSystems = [
        "aarch64-darwin"
      ];

      # Helper for generating attribute sets
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      # Full NixOS builds
      nixosConfigurations = { };

      # Full macOS builds
      darwinConfigurations = {
        lupus = import ./host/lupus { inherit inputs globals overlays; };
        minmus = import ./host/minmus { inherit inputs globals overlays; };
      };

      # Development environments
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          # For working on this repository
          default = pkgs.mkShell {
            packages = [
              pkgs.git
              pkgs.nixfmt-rfc-style
            ];
          };
        }
      );

      # Standalone applications
      packages = { };

      # For formatting the repository
      # "nix fmt"
      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system overlays; };
        in
        pkgs.nixfmt-rfc-style
      );
    };
}
