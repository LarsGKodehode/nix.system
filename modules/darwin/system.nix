{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {

    services.nix-daemon.enable = true;

    environment.shells = [ pkgs.fish ];

    security.pam.enableSudoTouchIdAuth = true;

    system = {

      stateVersion = 5;

      defaults = {
        NSGlobalDomain = { };

        dock = { };

        finder = { };

        CustomUserPreferences = { };

        CustomSystemPreferences = { };
      };
    };

    # Fix for: 'Error: HOME is set to "/var/root" but we expect "/var/empty"'
    home-manager.users.root.home.homeDirectory = lib.mkForce "/var/root";
  };
}
