{
  ...
}:

{
  imports = [
    ./system.nix
    ./user.nix
    ./networking.nix
    ./alacritty.nix
    # ./sketchybar # Disabled due to flickering
    ./aerospace
  ];
}
