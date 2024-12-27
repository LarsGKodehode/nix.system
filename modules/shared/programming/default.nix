{ ... }:

{
  imports = [
    ./kubernetes.nix
    ./infrastructure-as-code.nix
    ./nix.nix
    ./rust.nix
    ./dotnet.nix
    ./misc-tooling.nix
  ];
}
