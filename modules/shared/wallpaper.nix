{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    wallpaper = {
      enable = lib.mkEnableOption {
        description = "Enable desktop wallpaper configuration.";
        default = false;
      };

      # Static wallpaper: specify a concrete path
      # Example: wallpaper.path = { source = inputs.walls; path = "aerial/wallpaper.jpg"; }
      path = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.submodule {
            options = {
              source = lib.mkOption {
                type = lib.types.path;
                description = "Flake input source (e.g., inputs.walls).";
              };
              path = lib.mkOption {
                type = lib.types.str;
                description = "Path to image file relative to the source root.";
              };
            };
          }
        );
        description = "Static wallpaper path relative to a flake input source.";
        default = null;
      };

      # Dynamic wallpaper: specify an interval for random wallpaper updates
      # The wallpaper list will be determined by the filter predicate (not yet implemented)
      # Example: wallpaper.interval = "hourly";
      interval = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.enum [
            "hourly"
            "daily"
            "weekly"
          ]
        );
        description = "Interval for random wallpaper updates. If set, enables dynamic wallpaper mode. Wallpaper list will be determined by filter predicate.";
        default = null;
        example = "hourly";
      };

      # Future: filter predicate (Nix function) for filtering wallpapers
      # filter = lib.mkOption {
      #   type = lib.types.nullOr lib.types.functionTo lib.types.bool;
      #   description = "Nix predicate function for filtering wallpapers (not yet implemented).";
      #   default = null;
      # };
    };
  };

  config = lib.mkIf config.wallpaper.enable (
    lib.mkMerge [
      # macOS-specific wallpaper configuration
      (lib.mkIf pkgs.stdenv.isDarwin (
        let
          # Load unified wallpaper script
          wallpaperScript = pkgs.writeShellScriptBin "darwin-set-wallpaper" (
            builtins.readFile ./wallpaper/darwin-set-wallpaper.sh
          );

          # Static wallpaper mode
          staticConfig = lib.mkIf (config.wallpaper.path != null) {
            home-manager.users.${config.user} = {
              launchd.agents.setWallpaper = {
                enable = true;
                config = {
                  Label = "com.system.wallpaper";
                  ProgramArguments = [
                    "${wallpaperScript}/bin/darwin-set-wallpaper"
                    "exact"
                    "${config.wallpaper.path.source}/${config.wallpaper.path.path}"
                  ];
                  RunAtLoad = true;
                  KeepAlive = false;
                };
              };
            };
          };

          # Dynamic wallpaper mode (interval-based random selection)
          # TODO: Wallpaper list will be generated from filter predicate when implemented
          dynamicConfig = lib.mkIf (config.wallpaper.interval != null) (
            let
              # Convert interval to seconds for launchd StartInterval
              intervalSeconds =
                {
                  hourly = 3600; # 1 hour
                  daily = 86400; # 24 hours
                  weekly = 604800; # 7 days
                }
                .${config.wallpaper.interval};
              # Generate wallpaper list file as a Nix derivation
              # TODO: This will be populated from filter predicate (Nix function) when implemented
              # For now, generate an empty file - dynamic mode won't work until filter predicate is implemented
              wallpaperListFile = pkgs.writeText "wallpaper-list.txt" (
                # Empty file for now - will be populated by filter predicate
                ""
              );
            in
            {
              home-manager.users.${config.user} = {
                launchd.agents.setRandomWallpaper = {
                  enable = true;
                  config = {
                    Label = "com.system.random-wallpaper";
                    ProgramArguments = [
                      "${wallpaperScript}/bin/darwin-set-wallpaper"
                      "list"
                      (toString wallpaperListFile)
                    ];
                    StartInterval = intervalSeconds;
                    RunAtLoad = true;
                    KeepAlive = false;
                  };
                };
              };
            }
          );
        in
        lib.mkMerge [
          staticConfig
          dynamicConfig
        ]
      ))

      # Linux-specific wallpaper configuration
      (lib.mkIf pkgs.stdenv.isLinux {
        # TODO: Add Linux wallpaper support when needed
        # This could use feh, nitrogen, or other tools depending on the desktop environment
      })
    ]
  );
}
