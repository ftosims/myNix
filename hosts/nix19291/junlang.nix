{ pkgs, inputs, ... }:


{

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # zsh
  programs.zsh.enable = true;

  users.users.junlang = {
    isNormalUser = true;
    home = "/home/junlang";
    description = "Junlang";
    extraGroups = [ "networkmanager" "wheel" ];
    initialHashedPassword = "$y$j8T$/FC38MrZEQW8vfiDev2z10$7xgJiTRVmvR1ArWkZdL1sHqYsnf87O4jeCVRXNBa48.";
  };

}