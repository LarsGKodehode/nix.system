# Nix Systems

## [Hosts](/host/)

Set of configured hosts systems.

### MacOS
```sh
nix run nix-darwin -- switch --flake github:larsgkodehode/nix.system#<host-name>
```

### WSL

1. Download WSL image from [officual realease channel](https://github.com/nix-community/NixOS-WSL/releases) and follow their instructions.
2. Rebuild into the derivation provided here
```sh
sudo nixos-rebuild switch --flake github:larsgkodehode/nix.system#luna
```
3. (Optional) If you want to use the provided shell run `fish` inside the WSL container

