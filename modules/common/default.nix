{ inputs, custom, pkgs, system, ... }:
{
  imports = [
    (import "${inputs.self}/modules/cli" { inherit inputs pkgs system; })
  ];

  # The rough location
  location = {
    latitude = 46.948;
    longitude = 7.447;
  };

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  networking = {
    enableIPv6 = false;
    firewall.allowedTCPPorts = [ 22 ];
    # firewall.allowedUDPPorts = [ ... ];
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  programs.mosh.enable = true;
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Disable the root user
  users.users.root.hashedPassword = "!";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${custom.username} = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILFn/AElBrb+DOO3Mf075fGIfBuhd4UBIs91mJrZP11o dmytro@dkl3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBGyeBflbdU9G2eDbXLwl2TPAc4nMdg9icnXJZzY5po9 dmytro@dkpc1"
    ];
  };

  # allow non-free packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      nix-config.flake = inputs.self;
    };

    autoOptimiseStore = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
    # enable garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
    trustedUsers = [ "root" "@wheel" ];
  };

  environment.variables = {
    EDITOR = "vim";
    HIGHLIGHT_STYLE = "solarized-light";
  };

  security.sudo = {
    extraRules = [
      {
        users = [ "andreas" ];
        commands = [
          {
            command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild -j auto switch";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
          {
            command = "ALL";
            options = [ "SETENV" ];
          }
        ];
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = custom.version;
}

