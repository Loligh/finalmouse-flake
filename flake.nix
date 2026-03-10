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
        xpanel = import ./packages/xpanel/package.nix { inherit pkgs; };
        finalmouse-udev-rules = import ./packages/finalmouse-udev-rules/package.nix { inherit pkgs; };
      };

      nixosModules.hardware.finalmouse = ./modules/finalmouse.nix;
    };
}
