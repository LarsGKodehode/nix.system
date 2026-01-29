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
      settings = builtins.fromTOML (builtins.readFile ./config.toml);
    };
  };
}
