{ pkgs, ... }:
let

  myFonts = import ./fonts.nix { inherit pkgs; };
in
with pkgs; [
  # A
  autojump

  # G
  git

  # V
  vim

  # W
  wget

  # Z
  zsh-powerlevel10k


] ++ myFonts