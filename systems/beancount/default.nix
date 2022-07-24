{ config, custom, inputs, pkgs, ... }:
{
  imports = [
    (import "${inputs.self}/systems/proxmox-vm" {
      hostname = "beancount";
      inherit inputs;
    })
    "${inputs.self}/modules/code-server"
    "${inputs.self}/modules/docker"
    "${inputs.self}/modules/nix-direnv"
  ];
}
