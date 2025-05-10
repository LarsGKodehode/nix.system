{
  config,
  lib,
  ...
}:

{
  home-manager.users.${config.user}.programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''
      $os$username$hostname$directory$git_branch$git_commit$git_status
      $cmd_duration$character
      '';

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };

      directory = {
        truncate_to_repo = true;
        truncation_length = 100;
      };

      git_branch = {
        format = "[$symbol$branch]($style)";
      };

      git_commit = {
        format = "( @ [$hash]($style) )";
        only_detached = false;
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "⋄";
        stashed = "⩮";
        modified = "∽";
        staged = "+";
        renamed = "»";
        deleted = "✘";
        style = "red";
      };

      username = {
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        format = "[@$hostname](bold red) ";
        ssh_only = false;
      };

      fill = {
        symbol = " ";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        min_time = 1000;
        show_milliseconds = true;
      };

      os = {
        format = "$symbol";
        disabled = false;
        symbols = {
          Alpine = "🏔️";
          Arch = "🎗️";
          Debian = "🌀";
          Kali = "🐉";
          Macos = "🍎";
          NixOS = "❄️";
          Raspbian = "🍓";
          Ubuntu = "🎯";
          Unknown = "❓";
          Windows = "🪟";
        };
      };

    };
  };
}
