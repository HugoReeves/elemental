{ config, lib, pkgs, ... }:
with
lib;
{

  imports = [
    # DE
    ./de/karabiner/default.nix
    ./de/hammerspoon/default.nix
  ];

  config = mkIf (config.elemental.role == "darwin-laptop") {
    elemental.home.program.terminal.alacritty = {
      enable = true;
      settingOverrides = {
        shell.program = "/usr/local/bin/fish";
      };
    };

    elemental.home.program.shell.fish = {
      enable = true;
      preShellInit = ''
        bass source $HOME/.nix-profile/etc/profile.d/nix.sh
      '';
    };

    elemental.home.program.scripts.scriptFiles = {
      "set-wall" = ./script/set-wall;
    };

    elemental.home.program.de.karabiner.enable = true;
    elemental.home.program.de.hammerspoon.enable = true;


    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
    ];

    # Environment
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };


    programs.gpg = {
      enable = true;
      settings = {
        default-key = "0x484DEFFEF37B3BDB";
      };
    };
  };
}
