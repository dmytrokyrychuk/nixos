# nixos

This repository contains my configuration for my Nixos systems.
I don't provide any garantuees that it will work on other systems.
In addition some of the scripts required for installation will destroy your data when used.

Originally forked from https://git.2li.ch/Nebucatnetzer/nixos

## VM installation

This allows you to setup a VM with minimal effort.
However this requires some prerequisites.

- A VM running the minimal NixOS ISO reachable with SSH under nixos@nixos.home.kyrych.uk.
- The VM runs UEFI.
- You've set a password for the nixos user.

1. `./scripts/install_new_vm.xsh`
2. Provide the required information and wait until the script is finished.
3. Reboot and profit!

## Hardware installation

1. `curl -L https://github.com/dmytrokyrychuk/nixos/archive/refs/heads/main.tar.gz | tar xz && mv nixos-main nixos`
2. `cd nixos && nix-shell`
3. `sudo python3 scripts/format-disk.py`
4. `sudo nixos-install --no-root-passwd --root /mnt --impure --flake .#SYSTEMNAME`

## Update remote systems

Simply run the script `scripts/update_all_systems.xsh` and it will iterate over
all defined systems.
The script requires Xonsh but can be easily adapted to BASH or similar.

## Non-Nixos System

1. `scripts/install-home-manager.sh`
