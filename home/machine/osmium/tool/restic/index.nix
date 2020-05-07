{ config, lib, pkgs, ... }:
{
  elemental.home.program.admin.restic.includeDir = ./includes;
  elemental.home.program.admin.restic.excludeDir = ./excludes;
}
