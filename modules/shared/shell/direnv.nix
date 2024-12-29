{ config, ... }:

{
  # Enables quickly entering Nix shells when changing directories
  home-manager.users.${config.user}.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      whitelist = {
        prefix = [ config.dotfilesPath ];
      };
      # Disable environment variable diff dump
      # Nix environment variables are just to nosisy
      hide_env_diff = true;
    };
  };

  # Prevent garbage collection
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
