{
  lib,
  qt6Packages,
  stdenvNoCC,
  version
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-astro";
  version = version;

  src = lib.cleanSource ./.;

  dontConfigure = true;
  dontBuild = true; # might be why propogated build inputs do nothing?
  dontWrapQtApps = true;

  propagatedBuildInputs = with pkgs.qt6Packages; [
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

  # not sure how to fix the problem with the packages not showing up (below does not work)
  # right now I am using a band-aid (see greeter module)
  postFixup = '' 
    mkdir -p $out/nix-support

   echo ${qt6Packages.qtvirtualkeyboard} >> $out/nix-support/propagated-user-env-packages 
   echo ${qt6Packages.qtsvg}             >> $out/nix-support/propagated-user-env-packages 
   echo ${qt6Packages.qtmultimedia}       >> $out/nix-support/propagated-user-env-packages  
  '';
}

