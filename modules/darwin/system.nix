{
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    # Nice list of options:
    # https://mynixos.com/nix-darwin/options
    environment.shells = [ pkgs.fish ];
    security.pam.services.sudo_local.touchIdAuth = true;

    system = {
      stateVersion = 5;
      defaults = {

        NSGlobalDomain = {
          # Hide the menu bar
          _HIHideMenuBar = false;
          # Show all extensions
          AppleShowAllExtensions = true;
          # Always show all files
          AppleShowAllFiles = true;
          # Force dark mode (can be overridden by user preference)
          AppleInterfaceStyle = "Dark";
        };

        dock = {
          # Automatically show and hide the dock
          autohide = true;

          # Add translucency in dock for hidden applications
          showhidden = true;

          # Enable spring loading on all dock items
          enable-spring-load-actions-on-all-items = true;

          # Highlight hover effect in dock stack grid view
          mouse-over-hilite-stack = true;

          mineffect = "genie";
          orientation = "left";
          show-recents = false;
          tilesize = 44;

          persistent-apps = [
            "/Applications/1Password.app"
            "${pkgs.wezterm}/Applications/WezTerm.app"
          ];
        };
      };
    };

    # Fix for: 'Error: HOME is set to "/var/root" but we expect "/var/empty"'
    home-manager.users.root.home.homeDirectory = lib.mkForce "/var/root";
  };
}
