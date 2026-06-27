{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {

  name = "ibm-plex-sans-condensed-font";
  dontConfigure = true;
  src = pkgs.fetchzip {
    url = "https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-sans-condensed%402.0.0/ibm-plex-sans-condensed.zip";
    sha256 = "sha256-prqyJIPs+UpQxFTbn/eAfsG/jKwQTOO72fZNzAtXUWg=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -R $src/* $out/share/fonts/truetype/
  '';
  meta.description = "IBM Plex Sans Condensed Family";
}
