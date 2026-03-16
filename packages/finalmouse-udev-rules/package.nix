{
  lib,
  fetchurl,
  stdenv,
  udevCheckHook,
}:

stdenv.mkDerivation {
  pname = "finalmouse-udev-rules";
  version = "0.10";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/teamfinalmouse/xpanel-linux-permissions/13923c07d4739b3c698c3155e37e3770ba61705c/70-finalmouse.rules";
    sha256 = "WBxl2H2VNJtcRrgJsDcWPmn3tAkVOD3hGrm8WSA6JXs=";
  };

  nativeBuildInputs = [
    udevCheckHook
  ];

  doInstallCheck = true;

  dontUnpack = true;

  installPhase = ''
    install -Dpm644 $src $out/lib/udev/rules.d/70-finalmouse.rules
  '';

  meta = {
    homepage = "https://github.com/teamfinalmouse/xpanel-linux-permissions";
    description = "essential udev rules needed to ensure compatibility and proper permissions for Finalmouse devices";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Benji # !!!
    ];
  };
}
