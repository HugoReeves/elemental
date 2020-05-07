{ config, lib, pkgs, ... }:
with
lib;
{

  xdg.configFile = {
    "sxhkd/sxhkdrc" = {
      source = ./sxhkdrc;
      executable = true;
    };
  };
}
