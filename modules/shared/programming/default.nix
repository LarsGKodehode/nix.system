{ ... }:

{
  imports = [
    ./kubernetes.nix
    ./infrastructure-as-code.nix
    ./rust.nix
    ./dotnet.nix
  ];
}
