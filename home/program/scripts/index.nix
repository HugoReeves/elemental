{ config, lib, ... }:
with
lib;
let
  cfg = config.elemental.home.program.scripts;
  scripts = {
    "gopass-password-only" = ./misc/gopass-password-only;
    "mk-back" = ./misc/mk-back;
    "extract-back" = ./misc/extract-back;
  };
in
{
  options.elemental.home.program.scripts = {
    enable = mkEnableOption "Enable home scripts";

    scriptFiles = mkOption {
      type = types.attrsOf types.path;
      default = { };
      description = "Files to source into the scripts directory.";
    };
  };

  config = mkIf cfg.enable {

    # Map script files into the scripts directory
    xdg.configFile = mapAttrs'
      (n: v: nameValuePair "scripts/${n}" {
        source = v;
        executable = true;
      })
      (scripts
        //
        cfg.scriptFiles);
  };
}
