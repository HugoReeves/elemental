{ config, lib, ... }:

{
  imports = [
    ./machine/default.nix
    ./program/default.nix
    ./role/default.nix
    ./user/default.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  manual.manpages.enable = false;
}
