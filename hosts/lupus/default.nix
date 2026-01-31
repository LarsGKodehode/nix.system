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
        colors = (import ../../colorscheme/ashes).theme;
        dark = true;
      };

      # Applications
      _1password-cli.enable = true;
      wezterm.enable = true;

      # Desktop
      wallpaper = {
        enable = true;
        source = inputs.walls;
        dynamic = {
          interval = "hourly";
          filter = path: builtins.match "^apeiros/.*" path != null;
        };
      };

      # Programming Toolchains
      toolchain.nix.enable = true;
      toolchain.kubernetes.enable = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = 5;
    }
  ];
}
