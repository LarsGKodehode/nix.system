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
      networking.hostName = "minmus";

      theme = {
        colors = (import ../../colorscheme/gruvbox-dark).dark;
        dark = true;
      };

      # Applications
      alacritty.enable = true;

      # Language Toolchains

      # Services
    }
  ];
}
