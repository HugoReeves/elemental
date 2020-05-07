{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.elemental.home.program.dev.git;
in
{
  options.elemental.home.program.dev.git = {
    enable = lib.mkEnableOption "Enable git";

    userEmail = lib.mkOption {
      type = types.lines;
      description = "The git config email";
      default = "";
    };

    userName = lib.mkOption {
      type = types.lines;
      description = "The git config name";
      default = "";
    };

    gpgKey = lib.mkOption {
      type = types.lines;
      description = "The gpg-signing key";
      default = "";
    };

    signByDefault = lib.mkOption {
      type = types.bool;
      description = "Whether to gpg sign by default";
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = cfg.userEmail;
      userName = cfg.userName;
      signing.key = cfg.gpgKey;
      signing.signByDefault = cfg.signByDefault;
      delta.enable = true; # Use Delta for diff viewing
      extraConfig = {
        # Force SSH
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
        # Pull behaviour
        pull.rebase = false;
      };
      # Aliases
      aliases = {
        "s" = "status";
        "co" = "checkout";
        "br" = "branch";
        # Commits, additions, and modifications
        "cm" = "commit -m";
        "aa" = "add .";
        "rh" = "reset --hard";
        # Logging
        "lgo" = "log --oneline --graph";
        "lo" = "log --oneline";
        "ln" = "log -n"; # follow with a number to show n logs
        "lon" = "log --oneline -n"; # follow with a number to show n logs
      };
    };
  };
}
