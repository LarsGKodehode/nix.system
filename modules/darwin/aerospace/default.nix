{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {
    programs.aerospace = {
      enable = true;
      userSettings = builtins.fromTOML (builtins.readFile ./config.toml);
    };
  };
}
