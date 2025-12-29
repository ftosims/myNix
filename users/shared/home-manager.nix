{ config, pkgs, lib, ... }:

let name = "Junlang";
  user = "junlang";
  email = "junlangw@outlook.com"; in
{
  zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./config;
          file = "p10k.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ 
                  "autojump" 
                  "emoji"
                  "git"  
                  "sudo" 

                ];
      custom = "$HOME/.oh-my-zsh/custom/";
      # theme = "powerlevel10k/powerlevel10k";
    };
  };

  

}