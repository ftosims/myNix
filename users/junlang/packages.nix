{ pkgs, inputs, config ? null }:
with pkgs;
let
  # Shared-packages between mac and my mini PC.
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
  # shared-packages = [];
in 
shared-packages ++ [
  # A
  alacritty

  # C
  cachix

  # F
  fuzzel

  # G
  gh

  # K
  kitty
  
  # P
  # python314
  pciutils

  # R
  rofi

  # S
  swaylock

  # V
  vscode
  
  # W
  waybar
  wlr-randr

  # X
  xwayland-satellite
]
