{
  ...
}:

{
  imports = [
    ./system.nix
    ./user.nix
    ./networking.nix
    ./alacritty.nix
    ./homebrew.nix
    # ./sketchybar # Disabled due to flickering
    ./aerospace
  ];
}
