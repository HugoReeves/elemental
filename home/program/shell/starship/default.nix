{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.program.shell.starship;
in
{
  options.elemental.home.program.shell.starship = {
    enable = mkEnableOption "Enable the starship prompt";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        scan_timeout = 30;
        gcloud = {
          disabled = true;
        };
      };
    };
  };
}
