{
  config,
  pkgs,
  lib,
  ...
}:

{
  # macOS-specific settings for WezTerm
  home-manager.users.${config.user} = lib.mkIf pkgs.stdenv.isDarwin {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = wezterm.config_builder()

        -- Font with fallback for Nerd Font symbols
        config.font = wezterm.font_with_fallback({
          'Monaspace Argon NF',
          'Symbols Nerd Font',
        })
        config.font_size = 20.0

        return config
      '';
    };
  };
}
