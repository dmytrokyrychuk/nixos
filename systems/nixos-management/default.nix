{ config, custom, inputs, pkgs, ... }:
{
  imports = [
    (import "${inputs.self}/systems/proxmox-vm" {
      hostname = "nixos-management";
      inherit inputs;
    })
    "${inputs.self}/modules/code-server"
    "${inputs.self}/modules/docker"
    "${inputs.self}/modules/nix-direnv"
    "${inputs.self}/modules/tmux"
  ];
  # Required to build aarch64 packages
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
