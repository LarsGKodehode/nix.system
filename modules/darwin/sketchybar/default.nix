{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    environment.systemPackages = with pkgs; [
      sketchybar
      sketchybar-app-font
    ];

    # Auto hide the default status bar
    system.defaults.NSGlobalDomain._HIHideMenuBar = true;

    # Start sketchybar service
    services.sketchybar = {
      enable = true;
      config = ''
        ${pkgs.sketchybar}/bin/sketchybar --reload $HOME/.config/sketchybar/sketchybarrc
      '';
    };

    home-manager.users.${config.user} = {
      # Configuration
      home.file = {
        ".config/sketchybar" = {
          source = lib.cleanSourceWith { src = lib.cleanSource ./config; };
          recursive = true;
        };

        ".config/sketchybar/sketchybarrc" = {
          executable = true;
          text = builtins.readFile ./config/sketchybarrc;
        };
      };
    };
  };
}
