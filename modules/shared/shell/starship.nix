{
  config,
  ...
}:

{
  home-manager.users.${config.user}.programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      # Formatting here differs betwen systems (likely terminal emulators)
      format = "$os$username$hostname $directory\n$character";
      # Right-aligned contextual information (cmd duration and git info)
      right_format = "$cmd_duration$git_status $git_branch$git_commit";

      character = {
        success_symbol = "[󰘧](bold green)";
        error_symbol = "[󰘧](bold red)";
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
        format = " (@[$hash]($style))";
        only_detached = false;
      };

      git_status = {
        # Semantic coloring:
        # - Yellow: uncommitted changes (needs attention)
        # - Blue: upstream differences (sync needed)
        format = "([$modified$deleted$staged$untracked](bright-yellow bold) [$ahead_behind](bright-blue bold))";
        # Actionable states that require attention
        modified = "M";
        deleted = "D";
        untracked = "U";
        staged = "S";
        # Upstream states (mathematical symbols for difference)
        ahead = "Δ\${count}";
        behind = "∇\${count}";
        diverged = "Δ∇\${ahead_count}/\${behind_count}";
        up_to_date = "";
      };

      username = {
        format = "[$user](yellow)";
        show_always = true;
      };

      hostname = {
        format = "[@](dimmed)[$hostname](purple)";
        ssh_only = false;
      };

      cmd_duration = {
        format = "[$duration]($style)";
        min_time = 1000;
        show_milliseconds = true;
      };

      os = {
        format = "$symbol ";
        disabled = false;
        symbols = {
          NixOS = "";
          Debian = "";
          Macos = "";
          Windows = "";
          Unknown = "";
        };
      };

    };
  };
}
