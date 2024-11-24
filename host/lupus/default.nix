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
        homePath = "/Users/zab";
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

      # Services
    }
  ];
}
