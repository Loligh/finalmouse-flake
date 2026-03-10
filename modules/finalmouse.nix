{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  options.hardware.finalmouse.enable = lib.mkEnableOption "support for finalmouse devices";

  config = lib.mkIf config.hardware.finalmouse.enable {
    environment.systemPackages = [ self.packages.x86_64-linux.xpanel ];
    services.udev.packages = [ self.packages.x86_64-linux.finalmouse-udev-rules ];
  };
}
