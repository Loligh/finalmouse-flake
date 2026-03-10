{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.hardware.finalmouse.enable = lib.mkEnableOption "support for finalmouse devices";

  config = lib.mkIf config.hardware.wooting.enable {
    environment.systemPackages = [ pkgs.xpanel ];
    services.udev.packages = [ pkgs.finalmouse-udev-rules ];
  };
}
