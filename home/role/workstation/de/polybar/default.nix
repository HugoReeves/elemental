{ config, lib, pkgs, ... }:
with
lib;
{
  services.polybar = {
    enable = true;
    config = ./config;
    script = "polybar bottom &";
  };
}
