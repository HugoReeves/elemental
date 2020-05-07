{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.program.de.hammerspoon;
in
  {
    options.elemental.home.program.de.hammerspoon = {
      enable = mkEnableOption "Enable Hammerspoon keyboard plugin system";
    };
    config = mkIf cfg.enable {
      home.file = {
        ".hammerspoon" = {
          source = ./directory;
        };
      };
    };
}
