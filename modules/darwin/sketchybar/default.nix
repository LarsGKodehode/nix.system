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
    ];
    system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    services.sketchybar = {
      enable = false;
      config = ''
        sketchybar --bar height=24
        sketchybar --update
        echo "sketchybar configuration loaded.."
      '';
    };
  };
}
