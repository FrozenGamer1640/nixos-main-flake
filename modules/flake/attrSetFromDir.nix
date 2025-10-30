{ lib, ... }:
{ directory, pkgs }:
  let
    callPackage = lib.callPackageWith {
      inherit pkgs;
    };

    allFiles = builtins.readDir directory;

    nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) allFiles;
  in
  lib.mapAttrs' (name: type:
    {
      name = lib.removeSuffix ".nix" name;
      value = callPackage (directory + "/${name}") {};
    }
  ) nixFiles
