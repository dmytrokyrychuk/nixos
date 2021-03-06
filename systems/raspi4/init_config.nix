{ config, pkgs, lib, ... }:
{
  imports = [ "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/32f61571b486efc987baca553fb35df22532ba63.tar.gz" }/raspberry-pi/4" ];

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

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
  ];

  services.openssh.enable = true;
  networking.hostName = "nixos";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  };

  users = {
    mutableUsers = false;
    users."nixos" = {
      isNormalUser = true;
      initalPassword = "password";
      extraGroups = [ "wheel" ];
    };
  };
}
