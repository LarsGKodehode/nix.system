<h1 align="center">
 <img height="160" src="https://brand.nixos.org/logos/nixos-logo-rainbow-gradient-white-regular-horizontal-recommended.svg" />
 <p>Nix System Config for <a href="https://github.com/LarsGKodehode">zabronax</a></p>
</h1>

<p align="center">
 <a href="https://github.com/LarsGKodehode/nix.system/stargazers"><img src="https://img.shields.io/github/stars/LarsGKodehode/nix.system?colorA=282828&colorB=fabd2f&style=for-the-badge"></a>
 <a href="https://github.com/LarsGKodehode/nix.system/commits"><img src="https://img.shields.io/github/last-commit/LarsGKodehode/nix.system?colorA=282828&colorB=d79921&style=for-the-badge"></a>
 <a href="https://github.com/LarsGKodehode/nix.system/blob/main/LICENSE"><img src="https://img.shields.io/github/license/LarsGKodehode/nix.system?colorA=282828&colorB=83a598&style=for-the-badge"></a>
 <a href="https://wiki.nixos.org/wiki/Flakes" target="_blank">
 <img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=ebdbb2&label=Nix%20Flakes&labelColor=458588&message=Ready&color=ebdbb2&style=for-the-badge"></a>
</p>

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

```sh
.
├ colorscheme    # Base16 theme definitions
├ hosts          # Host-specific compositions
└ modules
  ├ darwin       # macOS-specific
  └ shared       # Cross-platform
```

## Common Commands

```sh
# Format code
nix fmt

# Update flake lock
nix flake update

# Enter dev shell
nix develop
```

