{ config, lib, ... }:

{
  imports = [
    ./dev/lorri/default.nix
    ./media/mpd/default.nix
  ];
}
