{
  appimageTools,
  fetchurl,
  lib,
  makeWrapper,
}:

let
  pname = "Xpanel";
  version = "1.1.1";
  src = fetchurl {
    url = "https://github.com/teamfinalmouse/xpanel-desktop-public/releases/download/v${version}/xpanel-desktop-${version}.AppImage";
    sha256 = "sha256-cmZX6E1Z2RdrB+uDJWeBm3woyVArmLl2+NvWhyEB3BI=";
  };
in

appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands =
    let
      contents = appimageTools.extract { inherit pname version src; };
    in
    ''
      wrapProgram $out/bin/xpanel \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

      install -Dm444 ${contents}/xpanel.desktop -t $out/share/applications
      install -Dm444 ${contents}/xpanel.png -t $out/share/icons/hicolor/1024x1024/apps
      substituteInPlace $out/share/applications/xpanel.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=xpanel'
    '';

  profile = ''
    export LC_ALL=C.UTF-8
  '';

  extraPkgs =
    pkgs: with pkgs; [
      libxshmfence
    ];

  meta = {
    homepage = "https://xpanel.finalmouse.com/";
    description = "Customization and management software for finalmouse devices";
    platforms = lib.platforms.linux;
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      Benji # !!!
    ];
    mainProgram = "xpanel";
  };
}
