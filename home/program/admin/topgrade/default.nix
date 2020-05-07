{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.elemental.home.program.admin.topgrade;
in
{
  options.elemental.home.program.admin.topgrade = {
    enable = mkEnableOption "Enable topgrade for convenient upgrades across package managers";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.topgrade ];
    xdg.configFile."topgrade.toml".source = ./topgrade.toml;
  };
}
