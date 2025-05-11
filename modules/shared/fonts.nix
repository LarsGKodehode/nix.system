{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.users.${config.user} = {
    fonts = {
      fontconfig.enable = true;
    };
  };

  # Add NerdFonts
  fonts = {
    packages = [
      pkgs.nerd-fonts.ubuntu-mono
      pkgs.nerd-fonts.hack
    ];
  };
}
