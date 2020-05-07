{ config, lib, pkgs, ... }:
with lib;
{
  config = mkIf (config.elemental.user == "x") {
    elemental.home = {
      program = {
        admin.topgrade.enable = true;
        editor.neovim.enable = true;
        filemanager.ranger.enable = true;
        networking.ssh.enable = true;
        networking.nmap.enable = true;
        scripts.enable = true;
        shell.fish.enable = true;
        shell.starship.enable = true;
        terminal.tmux.enable = true;

        dev.git = {
          enable = true;

          userEmail = "hugo@hugoreeves.com";
          userName = "Hugo Reeves";
          gpgKey = "0xE5D84E498A9A056E";
          signByDefault = true;
        };
      };
    };

    # Install packages
    home.packages = with pkgs; [
      # Rust CLI Tools! I love rust.
      bandwhich
      bat
      broot
      dogdns
      gitAndTools.delta
      exa
      fd
      fd
      hexyl
      hyperfine
      #navi
      #nushell
      ripgrep
      ripgrep
      starship
      tokei
      topgrade
      xsv

      # Utils
      age
      bottom
      dasel
      minisign
      nmap
      nodePackages.insect
      pueue
      pwgen
      rage
      ssh-audit
      units
      zoxide

      # Common CLI tools
      fzf
      gnupg
      gnutar
      gopass
      termtosvg

      # Development
      ctags
      direnv
      dnsutils
      elixir
      exercism
      git-crypt
      gitAndTools.gitflow
      glow
      gnumake
      go
      lorri
      lua
      luarocks
      manix
      niv
      nix-prefetch-git
      nixpkgs-fmt
      nodejs
      pre-commit
      rustup
      terraform_0_12
      tmux
      vagrant
      yarn
      ## Python Dev
      #python37Packages.jupyterlab
      python37Packages.pylint


      # Files and networking
      #brig
      #gcsfuse
      aria2
      b3sum
      croc
      dua
      gocryptfs
      ipfs
      magic-wormhole
      nnn
      qrencode
      ranger
      restic
      syncthing
      whois
      wrk
      zstd

      # Media
      youtube-dl
      imagemagick

      # Overview
      htop
      lazygit
      neofetch

      # Jokes
      cowsay
      fortune
      figlet
      lolcat
      nms
    ] ++ lib.optionals stdenv.isLinux [
      # Data, Files and Networking
      sshfs
      iotop
      fio
    ];
  };
}
