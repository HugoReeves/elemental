{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.elemental.home.service.dev.lorri;
in
{
  options.elemental.home.service.dev.lorri = {
    enable = mkEnableOption "Enable the Lorri daemon for better nix development";
  };

  config = mkIf cfg.enable {
    services.lorri = {
      enable = true;
    };
  };
}
