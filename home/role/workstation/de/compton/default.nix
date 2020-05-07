{ config, lib, pkgs, ... }:
with
lib;
{
  home.packages = with pkgs; [
    compton
  ];

  xdg.configFile = {
    "compton/compton.conf".source = ./compton.conf;
  };
}
