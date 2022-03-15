{ inputs, hostname, ip, ... }:
{
  imports = [
    (import "${inputs.self}/modules/mk-network" { inherit hostname ip; })
  ];
  inputs.nixos-hardware.nixosModules.raspberry-pi-4;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  hardware.raspberry-pi."4".fkms-3d.enable = true;
  hardware.raspberry-pi."4".audio.enable = true;
  hardware.pulseaudio.enable = true;

  environment.noXlibs = true;
  documentation.enable = false;
  documentation.nixos.enable = false;
  programs.command-not-found.enable = false;
}
