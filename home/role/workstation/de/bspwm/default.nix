{ config, lib, pkgs, ... }:
with
lib;
{
  xdg.configFile = {
    "bspwm/bspwmrc" = {
      source = ./bspwmrc;
      executable = true;
    };
  };
}
