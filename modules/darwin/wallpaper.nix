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

      # Path relative to a flake input source
      # Example: wallpaper.sourcePath = { source = inputs.walls; path = "aerial/wallpaper.jpg"; }
      sourcePath = lib.mkOption {
        type = lib.types.submodule {
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
        };
        description = "Wallpaper path relative to a flake input source.";
      };
    };
  };

  config = lib.mkIf (config.wallpaper.enable && pkgs.stdenv.isDarwin) {
    # Set wallpaper via launchd agent that runs in user context
    # Activation scripts run as root and can't set user wallpapers
    home-manager.users.${config.user} = {
      launchd.agents.setWallpaper = let
        # Image path from flake input source
        wallpaperPath = "${config.wallpaper.sourcePath.source}/${config.wallpaper.sourcePath.path}";
        
        # AppleScript to set wallpaper - escape single quotes and backslashes
        escapedPath = lib.replaceStrings [ "\\" "'" ] [ "\\\\" "\\'" ] wallpaperPath;
        setWallpaperScript = "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"${escapedPath}\"";
      in {
        enable = true;
        config = {
          Label = "com.system.wallpaper";
          ProgramArguments = [
            "/usr/bin/osascript"
            "-e"
            setWallpaperScript
          ];
          RunAtLoad = true;
          # Only run once, don't keep alive
          KeepAlive = false;
        };
      };
    };
  };
}
