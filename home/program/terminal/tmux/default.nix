{ lib, pkgs, config, ... }:
with
lib;
let
  cfg = config.elemental.home.program.terminal.tmux;
in
{
  options.elemental.home.program.terminal.tmux = {
    enable = mkEnableOption "Enable to tmux terminal multiplexer";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tmux ];
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
