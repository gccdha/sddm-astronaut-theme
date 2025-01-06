{
  lib,
  qt6Packages,
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

  propagatedBuildInputs = with qt6Packages; [
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

  postFixup = ''
    mkdir -p $out/nix-support

   echo ${qt6Packages.qtvirtualkeyboard} >> $out/nix-support/propagated-user-env-packages 
   echo ${qt6Packages.qtsvg}             >> $out/nix-support/propagated-user-env-packages 
   echo ${qt6Packages.tmultimedia}       >> $out/nix-support/propagated-user-env-packages  
  '';
}

