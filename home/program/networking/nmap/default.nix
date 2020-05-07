{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.elemental.home.program.networking.nmap;
in
{
  options.elemental.home.program.networking.nmap = {
    enable = mkEnableOption "Enable nmap";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nmap ];
    xdg.configFile."nmap/scripts/vulners.nse".source = ./scripts/vulners.nse;
  };
}
