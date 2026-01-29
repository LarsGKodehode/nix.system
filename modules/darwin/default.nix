{
  ...
}:

{
  imports = [
    ./system.nix
    ./user.nix
    ./networking.nix
    ./wezterm.nix
    # ./alacritty.nix  # Disabled in favor of WezTerm
    ./aerospace
  ];
}
