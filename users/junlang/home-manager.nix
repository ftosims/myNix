# https://github.com/mitchellh/nixos-config/blob/main/users/mitchellh/home-manager.nix
{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

let
  user     = "junlang";
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux  = pkgs.stdenv.isLinux;
  shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
  # shared-files = import ./files.nix { inherit config pkgs; };

in {
  imports = [
    inputs.niri-flake.homeModules.niri
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {inherit inputs config;};
    file = import ./files.nix { inherit user config pkgs; };
    stateVersion = "25.11";
  };

  programs = shared-programs // {
    # home-manager.enable = true;
    kitty = {
      enable = true;
      font.name = "Hack";
      shellIntegration.enableZshIntegration = true;
      settings = {
        shell = "zsh";
      };
    };
    niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

}
