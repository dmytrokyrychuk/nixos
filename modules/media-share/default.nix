{ ... }:
{
  fileSystems."/mnt/media" = {
    device = "10.7.89.108:media";
    fsType = "nfs";
  };
}