{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.elemental.home.program.shell.fish;
in
{
  options.elemental.home.program.shell.fish = {
    enable = mkEnableOption "Enable the fish shell";

    functionFiles = mkOption {
      type = types.attrsOf types.path;
      default = { };
      example = ''
        {
          "./restic-pd.fish"= ./restic-pd.fish;
        }
      '';
    };

    preShellInit = mkOption {
      type = types.lines;
      default = "";
      description = "Prepend to the shell init script";
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAbbrs = {
        v = "nvim";
        vim = "nvim";

        p = "gopass";
        g = "git";
        c = "cargo";
        r = "ranger";
        tma = "tmux attach -t";
        tmns = "tmux new-session -t";
        wet = "curl wttr.in";

        # Alias like
        cat = "bat";
        ls = "exa";
        l = "exa";
        ll = "exa -l";
        lll = "exa -la";
        lt = "exa -T";
      };

      shellAliases = {
        tmux = "tmux -f ~/.config/tmux/tmux.conf";
      };

      promptInit = builtins.readFile ./prompt.fish;

      shellInit = cfg.preShellInit + ''
        set PATH $HOME/.config/scripts $PATH
        direnv hook fish | source
        source ~/.ssh/environment > /dev/null
      '';

      interactiveShellInit = ''
        eval (starship init fish)
        source $HOME/.config/fish/fzf-colors.fish
        zoxide init fish | source
        bind \cb beginning-of-line
      '';
    };

    xdg.configFile =
      {
        "fish/fzf-colors.fish" = {
          source = ./fzf-colors.fish;
        };
        "fish/functions/start_ssh_agent.fish" = {
          source = ./functions/start_ssh_agent.fish;
          executable = false;
        };
      }
      //
      (
        mapAttrs'
          (n: v: nameValuePair ("fish/functions/${n}") { source = v; executable = false; })
          cfg.functionFiles
      );
  };
}
