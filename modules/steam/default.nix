{ inputs, custom, ... }:
{
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 27036 ];
    allowedUDPPorts = [ 27031 ];
  };
  home-manager.users.${custom.username} = {
    home.file.".local/share/applications/steam.desktop".source = ./steam.desktop;
  };
}
