{
  description = "finalmouse Xpanel + udev rules";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        xpanel = import ./packages/xpanel/package.nix {
          appimageTools = pkgs.appimageTools;
          fetchurl = pkgs.fetchurl;
          makeWrapper = pkgs.makeWrapper;
          lib = pkgs.lib;
        };
        finalmouse-udev-rules = import ./packages/finalmouse-udev-rules/package.nix {
          stdenv = pkgs.stdenv;
          fetchurl = pkgs.fetchurl;
          udevCheckHook = pkgs.udevCheckHook;
          lib = pkgs.lib;
        };
      };

      nixosModules.hardware.finalmouse = ./modules/finalmouse.nix;
    };
}
