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
        # - Yellow: uncommitted changes (needs attention)
        # - Blue: upstream differences (sync needed)
        # Custom format splitting out individual status variables for color control
        # Format: uncommitted changes (yellow) | upstream status (blue)
        # $ahead_behind is a smart variable that shows: diverged, ahead, behind, or up_to_date
        # Whitespace between groups for visual separation
        format = "([$modified$deleted$staged$untracked](bright-yellow bold) [$ahead_behind](bright-blue bold))";
        # Actionable states that require attention
        # Working directory states (letters for clarity)
        modified = "M";   # Dirty working directory (modified files)
        deleted = "D";    # Tracked file deleted from working directory
        untracked = "U";  # Untracked files
        staged = "S";     # Staged but not committed
        # Upstream states (mathematical symbols for difference)
        ahead = "Δ";      # Committed but not pushed (delta = increment)
        behind = "∇";     # Behind upstream (nabla = divergence operator)
        diverged = "Δ∇";  # Diverged from upstream (both delta and nabla)
        up_to_date = "";  # No upstream differences (empty, clean state)
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
