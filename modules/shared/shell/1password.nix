{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    _1password-cli = {
      enable = lib.mkEnableOption {
        description = "Enable 1Password CLI.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config._1password-cli.enable) {
    environment.systemPackages = with pkgs; [
      _1password-cli
    ];
  };
}
