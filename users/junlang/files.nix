{ user, pkgs, config, ... }:

{
  # Initializes Emacs with org-mode so we can tangle the main config
  #
  # @todo: Get rid of this after we've upgraded to Emacs 29 on the Macbook
  # Emacs 29 includes org-mode now
  ".config/niri/config.kdl" = {
    text = builtins.readFile ./config/niri/config.kdl;
  };

}
