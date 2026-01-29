# Nix Systems

Personal Nix configuration for macOS and WSL systems.

## Quick Start

### macOS
```sh
sudo darwin-rebuild switch --flake .#<host-name>
```

### WSL (luna)
```sh
sudo nixos-rebuild switch --flake .#luna
```

## Hosts

- **lupus** - Daily driver MacBook Air
- **minmus** - Minimal macOS system
- **luna** - WSL development environment

## Structure

- `hosts/` - Host-specific configurations
- `modules/shared/` - Cross-platform modules (shell, fonts, programming tools)
- `modules/darwin/` - macOS-specific modules (Aerospace, system settings)
- `colorscheme/` - Theme definitions (Base16 format)

## Common Commands

```sh
# Format code
nix fmt

# Update flake lock
nix flake update

# Enter dev shell
nix develop
```

