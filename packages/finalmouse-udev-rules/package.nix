{
  lib,
  fetchurl,
  stdenv,
  udevCheckHook,
}:

stdenv.mkDerivation {
  pname = "finalmouse-udev-rules";
  version = "0.1";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/teamfinalmouse/xpanel-linux-permissions/13923c07d4739b3c698c3155e37e3770ba61705c/70-finalmouse.rules";
    hash = "";
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
    description = "udev rules that give NixOS permission to communicate with finalmouse devices";
    platforms = lib.platforms.linux;
    # We think they are so simple that they are uncopyrightable
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      Benji # !!!
    ];
  };
}
