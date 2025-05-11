{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.${config.user} = {
    # Create nix-index if doesn't exist
    home.activation.createNixIndex =
      let
        cacheDir = "${config.homePath}/.cache/nix-index";
      in
      lib.mkIf config.home-manager.users.${config.user}.programs.nix-index.enable (
        config.home-manager.users.${config.user}.lib.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -d ${cacheDir} ]; then
              $DRY_RUN_CMD ${pkgs.nix-index}/bin/nix-index -f ${pkgs.path}
          fi
        ''
      );

    # Set automatic generation cleanup for home-manager
    nix.gc = {
      automatic = config.nix.gc.automatic;
      options = config.nix.gc.options;
    };
  };


  # faster rebuilding
  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = lib.mkDefault true;
  };

  nix = {
    # Set channel to flake packages, used for nix-shell commands
    nixPath = [ "nixpkgs=${pkgs.path}" ];

    # Set registry to this flake's packages, used for nix X commands
    registry.nixpkgs.to = {
      type = "path";
      path = builtins.toString pkgs.path;
    };

    # For security, only allow specific users
    settings.allowed-users = [
      "@wheel"
      config.user
    ];

    # Enable features in Nix commands
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    settings = {
      # Add community Cachix to binary cache
      builders-use-substitutes = true;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
