{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.program.admin.restic;
in
{
  options.elemental.home.program.admin.restic = {
    enable = mkEnableOption "Enable restic backup configuration";

    includeDir = mkOption {
      type = types.path;
      default = null;
      description = "Include files to source into the appropriate directory";
    };

    excludeDir = mkOption {
      type = types.path;
      default = null;
      description = "Exclude files to source into the appropriate directory";
    };

    enableFishScripts = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the fish scripts should be installed";
    };

    enableBackScript = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the back script should be installed into scripts";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.restic ];

    elemental.home.program.shell.fish.functionFiles = mkIf cfg.enableFishScripts {
      "restic-fd.fish" = ./fish-functions/restic-fd.fish;
      "restic-sd.fish" = ./fish-functions/restic-sd.fish;
      "restic-gcs.fish" = ./fish-functions/restic-gcs.fish;
    };

    elemental.home.program.scripts.scriptFiles = mkIf cfg.enableBackScript {
      "back" = ./back;
    };

    xdg.configFile = {
      "restic/envs".source = ./envs;
      "restic/includes" = mkIf (cfg.includeDir != null) {
        source = cfg.includeDir;
      };
      "restic/excludes" = mkIf (cfg.excludeDir != null) {
        source = cfg.excludeDir;
      };
    };
  };
}
