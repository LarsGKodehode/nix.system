{ config, pkgs, ... }:

{
  config = {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        age # Encryption
        delta # Fancy diffs
        dig # DNS lookup
        fd # find
        htop # Show system processes
        killall # Force quit
        inetutils # Includes telnet, whois
        jless # JSON viewer
        jo # JSON output
        jq # JSON manipulation
        qrencode # Generate qr codes
        rsync # Copy folders
        ripgrep # grep
        sd # sed
        tree # View directory hierarchy
        unzip # Extract zips
        dua # File sizes (du)
        dust # Disk usage tree (ncdu)
        duf # Basic disk information (df)
      ];
    };
  };
}
