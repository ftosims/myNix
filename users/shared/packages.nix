{ pkgs, ... }:
let

  myFonts = import ./fonts.nix { inherit pkgs; };
in
with pkgs; [
  
  # G
  git

  # V
  vim

  # W
  wget

  # Z
  zsh-powerlevel10k


] ++ myFonts