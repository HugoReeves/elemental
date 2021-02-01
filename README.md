# Elemental

**The component parts of a Nix/OS development system.**

Elemental is my attempt to create a configurable development environment built atop [Nix](https://nixos.org) and [Home Manager](https://github.com/nix-community/home-manager).
Elemental is currently setup for userspace configuration using Home Manager, I'm working on integrating my NixOS system configuration into the same repo using the same configuration techniques.

Configuration in Elemental is dividided into three sections, **Machine Configuration**, **Role Configuration** and **User Configuration**.
Custom derivations are stored under these three sections, the objective is to allow as much configuration to be shared where possible, whilst keeping configuration compartmentalised so that changing the machine, role or user is easily possible without rewritting configuration files.

### Machine

The machine configuration is specific to the individual host system, generally speaking, for each non-homogenous device you manage with Elemental, you should have a separate machine configuration.
Currently I maintain machine specific configurations for my NixOS workstation, a Intel Hades Canyon NUC, and my Darwin/MacOS laptop, a 2017 Macbook Pro running Big Sur.
Configuration that should be considered 'machine specific' includes things like backup configuration that is depenedent on the systems disk layout, and custom networking software that is specific to the system's hardware.

### Role

The majority of Elemental configuration fits into the role category.
Currently I maintain two separate role configurations, one for a NixOS workstation and one for a Darwin laptop.
Configuration that should be considered 'role' specific includes anything that touches GUI tools, the desktop environment, and shells or prompts.
The idea here is that two separate machines could me made to use the same role configuration, if you wanted the same desktop environment and general configuration on both machines.

In some situations, it makes sense to also consider the machine type within some of the Role configurations.
An example where this may occur is if you need to reference a machine specific wifi network interface in a desktop status bar configuration.
The component being configured here, the desktop status bar, is definitely a part of the role but it is also neccesary to reference the machine being targeted.
Some situations like this are unavoidable.

### User

User configuration primarily consists of installing the command line utilities the user should have access to, and configuring things like SSH, GPG and Git.
I share the same user, 'x', across all my systems.
By listing the commandline tools I need installed within the 'x' user configuration, I am able to keep the same tools installed on both my NixOS and MacOS machines.

# Usage and Installation

If you would like to adapt Elemental for your own purposes, I would encourage you to fork the repo and begin building your own machine, role and user configurations.

Before installing Elemental, you must install [Home Manager](https://github.com/nix-community/home-manager), see [here for instructions](https://github.com/nix-community/home-manager#installation).

Elemental should be installed to `~/.config/nixpkgs`.
I generally like to have my Elemental repo appear at `~/elemental`, so I choose to symlink it into `~/.config/nixpkgs`.

You will need to manually add a file called `home.nix` into the top level of your elemental repo.
This file is where you will set the Machine, Role and User to be used in your configuration, it will be ignored by git by default.
Within this file you should import `./elemental.nix` which defines elemental's configuration options.
You should also import `./home/default.nix` which imports the individual machine, role and user configuration files.
If deploying to a linux system, you should also import `./home/linux-only.nix` which imports configurations only available on Linux installations of Nix.

## MacOS Example

The following `home.nix` configuration is for my NixOS desktop.

```nix
{ config, pkgs, lib,... }:

{
  imports = [
    ./elemental.nix

    ./home/default.nix

    # Import the linux only derivations
    ./home/linux-only.nix
  ];

  # Let Home Manager install itself
  programs.home-manager.enable = true;
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  elemental.machine = "boron";
  elemental.role = "workstation";
  elemental.user = "x";
}
```

## MacOS Example

The following `home.nix` configuration is for my Macbook Pro running MacOS Big Sur.

```nix
# ./elemental.nix
{ config, pkgs, lib,... }:

{
  imports = [
    ./elemental.nix

    ./home/default.nix
  ];

  # Let Home Manager install itself
  programs.home-manager.enable = true;
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  elemental.machine = "osmium";
  elemental.role = "darwin-laptop";
  elemental.user = "x";
}
```
