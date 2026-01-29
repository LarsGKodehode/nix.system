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
        config.font_size = 12.0

        -- Gruvbox Dark color scheme using theme source
        config.colors = {
          background = '${config.theme.colors.base00}',
          foreground = '${config.theme.colors.base05}',
          cursor_bg = '${config.theme.colors.base05}',
          cursor_fg = '${config.theme.colors.base00}',
          ansi = {
            '${config.theme.colors.base00}', -- black
            '${config.theme.colors.base08}', -- red
            '${config.theme.colors.base0B}', -- green
            '${config.theme.colors.base0A}', -- yellow
            '${config.theme.colors.base0D}', -- blue
            '${config.theme.colors.base0E}', -- magenta
            '${config.theme.colors.base0C}', -- cyan
            '${config.theme.colors.base05}', -- white
          },
          brights = {
            '${config.theme.colors.base03}', -- bright black
            '${config.theme.colors.base09}', -- bright red
            '${config.theme.colors.base0B}', -- bright green
            '${config.theme.colors.base0A}', -- bright yellow
            '${config.theme.colors.base0D}', -- bright blue
            '${config.theme.colors.base0E}', -- bright magenta
            '${config.theme.colors.base0C}', -- bright cyan
            '${config.theme.colors.base07}', -- bright white
          },
        }

        -- Launch fish shell by default
        config.default_prog = { '${pkgs.fish}/bin/fish', '-l' }

        return config
      '';
    };
  };
}
