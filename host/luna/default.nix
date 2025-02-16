{
  inputs,
  globals,
  overlays,
}:

let
  system = "x86_64-linux";
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  modules = [
    ../../modules/shared
    (
      globals
      // rec {
        homePath = "/home/${globals.user}";
      }
    )
    inputs.wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    {
      # Pin state version
      system.stateVersion = "25.05";

      # Replace config with our directory, as it's sourced on every launch
      system.activationScripts.configDir.text = ''
        rm -rf /etc/nixos
        ln --symbolic --no-dereference --force /home/zab/system /etc/nixos
      '';

      # Configuration
      networking.hostName = "luna";

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
        dark = true;
      };

      # WSL specific
      wsl = {
        enable = true;
        defaultUser = globals.user;
        docker-desktop.enable = true;
        wslConf.network.generateResolveConf = true; # Turn off if it breaks VPN
        interop.includePath = false; #Including Windows PATH will slow down other systems, filesystem cross talk
      };

      # Enable the VS Code server for remote work
      # TODO! Figure out how to extract all parts of this into it's own module
      programs.nix-ld.enable = true;

      # Applications
      alacritty.enable = false;

      # Programming Toolchains
      toolchain.nix.enable = true;
      toolchain.misc-tooling.enable = false;
      toolchain.kubernetes.enable = false;
      toolchain.infrastructure-as-code.enable = false;
      toolchain.rust.enable = false;
      toolchain.dotnet.enable = false;
    }
  ];
}
