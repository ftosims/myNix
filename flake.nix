# https://github.com/mitchellh/nixos-config/blob/main/flake.nix
# /etc/nixos/flake.nix
{
  description = "NixOS systems by 192";
  inputs = {
    # NIXVERSION Primary nixpkgs repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    # NIXVERSION We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # NIXVERSION Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # snapd
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    # Niri
    niri-flake = {
      url = github:sodiboo/niri-flake;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, darwin, niri-flake, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      niri-flake.overlays.niri
      (final: prev: rec {

      })
    ];

    mkSystem1 = import ./lib/mksystem1.nix {
      inherit overlays nixpkgs inputs;
    };
    mkSystem = import ./lib/mksystem1.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    
    # Configuration for my miniPC
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.nix19291 = mkSystem1 "nix19291" {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      user   = "junlang";
    };
    darwinConfigurations.workmac = mkSystem1 "workmac" {
      system = "aarch64-darwin";
      user   = "junlangwang";
      darwin = true;
    };
  };
}
