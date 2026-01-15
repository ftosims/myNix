{ pkgs, inputs, config ? null }:
with pkgs;
let
  # Shared-packages between mac and my mini PC.
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
  # shared-packages = [];
in 
shared-packages ++ [
  # A

  # C
  cachix

  # F

  # G
  gh

  # I
  iterm2

  # K
  
  # P
  # python314

  # R

  # S
  # T
  # tailscale

  # V
  vscode
  
  # W

  # X
]
