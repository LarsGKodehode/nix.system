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
      format = "$os$username$hostname$directory\n$character";
      # Right-aligned contextual information (cmd duration and git info)
      right_format = "$cmd_duration$git_status$git_branch$git_commit";

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
        # - Red: divergence (major issue)
        # - Yellow: uncommitted changes (needs attention)
        # - Blue: upstream differences (sync needed)
        # Custom format splitting out individual status variables for color control
        # Using background colors and bold for better visibility
        format = "([$modified$deleted$staged$untracked](bg:bright-yellow bold)[$ahead$behind](bg:bright-blue bold)[$diverged](bg:bright-red bold))";
        # Actionable states that require attention
        modified = "∽";  # Dirty working directory (modified files)
        deleted = "✘";   # Tracked file deleted from working directory
        untracked = "⋄"; # Untracked files
        staged = "+";    # Staged but not committed
        ahead = "⇡";     # Committed but not pushed
        behind = "⇣";    # Behind upstream
        diverged = "⇕";  # Diverged from upstream
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
