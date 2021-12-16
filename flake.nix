{
  description = "Andreas Zweili's Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # look here for the hardware options https://github.com/NixOS/nixos-hardware/blob/master/flake.nix#L5
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , home-manager
    }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          overlay-unstable
        ];
      };
    in
    {
      nixosConfigurations.gwyn = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./hardware/precision/configuration.nix
          nixos-hardware.nixosModules.dell-precision-5530
          nixos-hardware.nixosModules.common-gpu-nvidia
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/desktop.nix
              {
                inherit inputs system pkgs;
              };
          }
        ];
      };
      nixosConfigurations.staubfinger = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./hardware/asus/configuration.nix
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/desktop.nix
              {
                inherit inputs system pkgs;
              };
          }
        ];
      };
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./hardware/vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andreas = import ./home-manager/desktop.nix
              {
                inherit inputs system pkgs;
              };
          }
        ];
      };
    };
}