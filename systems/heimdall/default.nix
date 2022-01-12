{ ... }:
{
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "dm-snapshot" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };
  fileSystems."/mnt/data" = {
    device = "10.7.89.108:raspi_data";
    fsType = "nfs";
  };

  networking = {
    hostName = "heimdall.2li.local";
    interfaces.ens18.ip4.addresses = [
      {
        address = "10.7.89.121";
        prefixLength = 24;
      }
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
