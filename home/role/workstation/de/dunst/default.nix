{ config, lib, pkgs, ... }:
with
lib;
{

  home.packages = with pkgs; [
    dunst
  ];

  services.dunst = {
    enable = true;
  };

  xdg.configFile = {
    "dunst/dunstrc".source = ./dunstrc;
  };
}
