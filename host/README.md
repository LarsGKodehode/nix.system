# Hosts

| Name     | Description               |
| -------- | ------------------------- |
| lupus    | Daily driver, MacBook Air |
| minmus   | Minimal MacOS system      |

## Install Instructions

1. Use the wanted host system

    ```sh
    nix run nix-darwin -- switch --flake github:LarsGKodehode/nix.system#<host-system>
    ```

### MacOS Prerequisites

1. Fresh install of MacOS
2. Install Nix, recommend using the [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer)

    ```sh
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
      sh -s -- install
    ```
