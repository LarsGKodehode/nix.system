{
  inputs,
  globals,
  overlays,
}:

inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";

  modules = [
    ../../modules/shared
    ../../modules/darwin
    (
      globals
      // rec {
        homePath = "/Users/${globals.user}";
      }
    )
    inputs.home-manager.darwinModules.home-manager
    {
      # Configuration
      networking.hostName = "lupus";

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
        dark = true;
      };

      # Applications
      alacritty.enable = true;

      # Programming Toolchains
      toolchain.misc-tooling.enable = false;
      toolchain.kubernetes.enable = true;
      toolchain.infrastructure-as-code.enable = true;
      toolchain.nix.enable = true;
      toolchain.rust.enable = false;
      toolchain.dotnet.enable = false;

      # Services
      dnsmasq.enable = true;
    }
  ];
}
