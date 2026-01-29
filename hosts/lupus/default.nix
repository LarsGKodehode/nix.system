{
  inputs,
  globals,
  overlays,
}:

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";

  # The modules list is executed in order
  modules = [
    # Unfree predicate for system packages
    # Needs to happen before any nixpkgs consumers are called
    (
      { config, pkgs, ... }:
      {
        nixpkgs.config.allowUnfreePredicate =
          pkg:
          builtins.elem (pkgs.lib.getName pkg) [
            "1password-cli"
          ];
      }
    )

    # Shared modules
    ../../modules/shared
    ../../modules/darwin

    # Home Manager
    inputs.home-manager.darwinModules.home-manager

    # Host-Global values
    (
      globals
      // {
        homePath = "/Users/${globals.user}";
      }
    )

    # Host specific configuration
    {
      # Configuration
      networking.hostName = "lupus";

      # Temporary fix for darwin-nix
      # TODO: Remove this once the "The Plan" is implemented (switching to system wide activation)
      # https://github.com/nix-darwin/nix-darwin/issues/1452
      system.primaryUser = globals.user;

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
        dark = true;
      };

      # Applications
      _1password-cli.enable = true;
      wezterm.enable = true;

      # Desktop
      wallpaper = {
        enable = true;
        sourcePath = {
          source = inputs.walls;
          path = "architecture/a_group_of_tall_buildings_in_a_city.jpg";
        };
      };

      # Programming Toolchains
      toolchain.nix.enable = true;
      toolchain.kubernetes.enable = true;
    }
  ];
}
