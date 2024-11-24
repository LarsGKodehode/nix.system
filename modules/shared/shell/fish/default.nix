{
  config,
  pkgs,
  lib,
  ...
}:
{

  users.users.${config.user}.shell = pkgs.fish;
  programs.fish.enable = true;

  home-manager.users.${config.user} = {
    # Packages used in abbreviations and aliases
    home.packages = with pkgs; [ curl ];

    programs.fish = {
      enable = true;

      shellAliases = {
        # Version of bash which works much better on the terminal
        bash = "${pkgs.bashInteractive}/bin/bash";

        # Use eza (exa) instead of ls for fancier output
        ls = "${pkgs.eza}/bin/eza --group";

        # Move files to XDG trash on the commandline
        trash = lib.mkIf pkgs.stdenv.isLinux "${pkgs.trash-cli}/bin/trash-put";
      };

      functions = { };

      interactiveShellInit = ''
        fish_vi_key_bindings
        bind yy fish_clipboard_copy
        bind Y fish_clipboard_copy
        bind -M visual y fish_clipboard_copy
        bind -M default p fish_clipboard_paste
        set -g fish_vi_force_cursor
        set -g fish_cursor_default block
        set -g fish_cursor_insert line
        set -g fish_cursor_visual block
        set -g fish_cursor_replace_one underscore
      '';

      loginShellInit = "";

      shellAbbrs = {
        # Directory aliases
        l = "ls -lh";
        lh = "ls -lh";
        ll = "ls -alhF";
        la = "ls -a";
        c = "cd";
        "-" = "cd -";
        mkd = "mkdir -pv";

        # System
        s = "sudo";
        sc = "systemctl";
        scs = "systemctl status";
        sca = "systemctl cat";
        m = "make";
        t = "trash";

        # Vim
        v = "vim";
        vl = "vim -c 'normal! `0'";

        # Cheat Sheets
        ssl = "openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr";
        fingerprint = "ssh-keyscan myhost.com | ssh-keygen -lf -";
        publickey = "ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub";

        # Docker
        dr = "docker run --rm -it";
        db = "docker build . -t";
      };

      shellInit = "";
    };

    home.sessionVariables.fish_greeting = "";

    programs.starship.enableFishIntegration = true;
    programs.fzf.enableFishIntegration = true;
  };
}