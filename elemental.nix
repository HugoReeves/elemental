{ config, lib, pkgs, ... }:
let
  cfg = config.elemental;
in
{

  options.elemental.machine = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The hostname of the device.
    '';
    example = "boron";
  };

  options.elemental.role = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The device role, this determines the window manager and GUI tools to be installed.
    '';
    example = "workstation";
  };

  options.elemental.user = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The username of the primary user.
    '';
    example = "x";
  };
}
