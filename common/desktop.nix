# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  networking = {
    networkmanager.enable = true;
  };

  services = {
    autorandr.enable = true;
    printing.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+qtile";
    windowManager.qtile.enable = true;
    layout = "us";
    xkbOptions = "compose:ralt";
    libinput.enable = true;
  };

  fonts.fonts = with pkgs; [
    source-code-pro
  ];

  # Enable keyring
  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # enable steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # enable lockscreen

  programs.xss-lock = {
    enable = true;
    lockerCommand = "i3lock -c 000000";
  };

  environment.variables = {
    ZWEILI_ENVIRONMENT = "desktop";
  };

  environment.systemPackages = with pkgs; [
    arc-theme
    celluloid
    evince
    firefox
    gimp
    i3lock
    inkscape
    libreoffice-fresh
    lxappearance
    networkmanagerapplet
    networkmanager-openvpn
    nitrogen
    pavucontrol
    rofi
    source-code-pro
    terminator
  ];
}

