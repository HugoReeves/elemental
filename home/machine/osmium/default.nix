{ config, lib, pkgs, ... }:
with
lib;
{
  config = mkIf (config.elemental.machine == "osmium") {
    elemental.home.program.admin.restic = {
      enable = true;
      enableFishScripts = true;
      enableBackScript = true;

      includeDir = ./restic/includes;
      excludeDir = ./restic/excludes;
    };
  };
}
