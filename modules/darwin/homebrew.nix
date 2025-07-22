{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Homebrew - Mac-specific packages that aren't in Nix
  config = lib.mkIf pkgs.stdenv.isDarwin {
    # Add homebrew paths to CLI path
    home-manager.users.${config.user}.home.sessionPath = [ "/opt/homebrew/bin/" ];

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false; # Don't update during rebuild
        cleanup = "zap"; # Uninstall all programs not declared
        upgrade = true;
      };

      global = {
        brewfile = true; # Run brew bundle from anywhere
        lockfiles = false; # Don't save lockfile (since running from anywhere)
      };

      brews = [
        "trash" # Delete files and folders to trash instead of rm
      ];

      casks = [
        "1password" # 1Password will not launch from Nix on macOS
        "orbstack" # Container runtime for MacOS
      ];
    };
  };
}
