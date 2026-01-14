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
    inputs.noctalia.homeModules.default
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
        # configure options
    noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "right";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "WiFi";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Nord";
        general = {
          avatarImage = "/home/junlang/.face";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = true;
          name = "Madrid, Spain";
        };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  };

  services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      # Niri
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
      time-to-sleep = 60 * 5;
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = time-to-sleep; # in seconds
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = time-to-sleep + 5;
          command = lock;
        }
        {
          timeout = time-to-sleep + 15;
          command = display "off";
          resumeCommand = display "on";
        }
      ];
      events = [
        {
          event = "before-sleep";
          # adding duplicated entries for the same event may not work
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };


    
}

