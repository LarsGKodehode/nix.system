{
  config,
  pkgs,
  lib,
  ...
}:

{
  home-manager.users.${config.user} = {
    fonts.fontconfig = {
      defaultFonts = {
        monospace = ["Monaspace Argon, Symbols Nerd Font"];
      };
      enable = true;
    };
  };

  # Add NerdFonts
  fonts.packages = with pkgs; [
    # Desktop Fonts
    b612 # high legibility
    material-icons
    material-design-icons

    # Emojis
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji

    # Nerd Fonts
    cascadia-code
    monaspace
    nerd-fonts.symbols-only
  ];
}
