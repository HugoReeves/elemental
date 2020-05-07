{ config, lib, pkgs, ... }:
with
lib;
let 
  cfg = config.elemental.home.program.de.karabiner;
in
  {
    options.elemental.home.program.de.karabiner = {
      enable = mkEnableOption "Enable Karabiner Elements keyboard plugin system";
    };

    config = mkIf cfg.enable {
      home.file = {
        ".karabiner/karabiner.json" = {
          source = ./karabiner.json;
          executable = false;
        };
      };
    };
}
