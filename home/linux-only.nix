{ config, lib, stdenv, ... }:

{
  imports = [
    ./machine/nixos-only.nix
    ./role/nixos-only.nix
    ./service/default.nix
  ];
}
