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

      # Helpers for generating attribute sets across systems
      withSystem = nixpkgs.lib.genAttrs [
        # "x86_64-linux"
        # "x86_64-darwin"
        # "aarch64-linux"
        "aarch64-darwin"
      ];

      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );
    in
    {
      # Full NixOS builds
      nixosConfigurations = { };

      # Full macOS builds
      darwinConfigurations = {
        lupus = import ./host/lupus { inherit inputs globals overlays; };
        minmus = import ./host/minmus { inherit inputs globals overlays; };
      };

      # Standalone applications
      packages = { };

      # Development environments
      devShells = withPkgs (pkgs: {
        # For working on this repository
        default = pkgs.mkShell {
          packages = [
            pkgs.git
          ];
        };
      });

      # For formatting the repository
      # "nix fmt"
      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
