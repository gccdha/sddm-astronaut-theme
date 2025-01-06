{
  lib,
  qt6,
  stenvNoCC,
  version
}:
stenvNoCC.mkDerivation {
  pname = "sddm-astro";
  version = version;

  src = lib.cleanSource ./.;

  dontConfigure = true;
  dontBuild = true;
  dontWrapQtApps = true;

  propagatedBuildInputs = with qt6; [
    qtvirtualkeyboard
    qtsvg
    qtmultimedia
  ];

  postInstall = ''
    mkdir -p $out/share/sddm/themes/sddm-astro
    mkdir -p $out/share/fonts

    mv * $out/share/sddm/themes/sddm-astro
    cp -r $out/share/sddm/themes/sddm-astro/Fonts/* $out/share/fonts
  '';
}

