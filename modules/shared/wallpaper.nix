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

      source = lib.mkOption {
        type = lib.types.path;
        description = "Flake input source containing wallpapers (e.g., inputs.walls).";
        example = "inputs.walls";
      };

      # Static wallpaper: specify a concrete path relative to source
      # Example: wallpaper.path = "aerial/wallpaper.jpg";
      path = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Path to image file relative to the source root (for static wallpaper mode).";
        default = null;
        example = "gruvbox/a_landscape_with_mountains_and_trees.jpg";
      };

      # Dynamic wallpaper: random selection with interval and filter
      dynamic = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.submodule {
            options = {
              interval = lib.mkOption {
                type = lib.types.enum [
                  "hourly"
                  "daily"
                  "weekly"
                ];
                description = "Interval for random wallpaper updates.";
                example = "hourly";
              };

              filter = lib.mkOption {
                type = lib.types.functionTo lib.types.bool;
                description = "Nix predicate function for filtering wallpapers. Takes a wallpaper path (relative to source) and returns true if it should be included.";
                example = "path: builtins.match \"^apocalypse/.*\" path != null";
              };
            };
          }
        );
        description = "Dynamic wallpaper selection configuration.";
        default = null;
      };
    };
  };

  config = lib.mkIf config.wallpaper.enable (
    lib.mkMerge [
      # macOS-specific wallpaper configuration
      (lib.mkIf pkgs.stdenv.isDarwin (
        let
          # Supported image file extensions for macOS wallpapers
          supportedImageExtensions = [
            ".jpg"
            ".jpeg"
            ".png"
            ".gif"
            ".heic"
            ".webp"
          ];

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
                    "${config.wallpaper.source}/${config.wallpaper.path}"
                  ];
                  RunAtLoad = true;
                  KeepAlive = false;
                };
              };
            };
          };

          # Dynamic wallpaper mode (random selection with filter)
          dynamicConfig = lib.mkIf (config.wallpaper.dynamic != null) (
            let
              # Convert interval to seconds for launchd StartInterval
              intervalSeconds =
                {
                  hourly = 3600; # 1 hour
                  daily = 86400; # 24 hours
                  weekly = 604800; # 7 days
                }
                .${config.wallpaper.dynamic.interval};

              # Find all wallpapers in source directory and filter them
              sourcePath = config.wallpaper.source;
              sourcePathStr = toString sourcePath;
              allFiles = lib.filesystem.listFilesRecursive sourcePath;
              # Filter to image files only using supported extensions
              imageFiles = lib.filter (
                absPath:
                let
                  pathStr = toString absPath;
                in
                lib.any (ext: lib.hasSuffix ext pathStr) supportedImageExtensions
              ) allFiles;
              # Convert absolute paths to relative paths for the filter function
              filteredWallpapers = lib.filter (
                absPath:
                let
                  relPath = lib.removePrefix (sourcePathStr + "/") (toString absPath);
                in
                config.wallpaper.dynamic.filter relPath
              ) imageFiles;

              # Generate wallpaper list file as a Nix derivation
              wallpaperListFile = pkgs.writeText "wallpaper-list.txt" (
                lib.concatStringsSep "\n" filteredWallpapers
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
