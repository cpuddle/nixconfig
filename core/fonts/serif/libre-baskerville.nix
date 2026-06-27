{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {

  name = "libre-baskerville-font";
  dontConfigure = true;
  src = pkgs.fetchzip {
    url = "https://www.1001fonts.com/download/libre-baskerville.zip";
    sha256 = "sha256-ZDREAwQmynTDeOVgjf4Fec8C6EQRtU0OXiIAmEfvn/4=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -R $src/* $out/share/fonts/truetype/
  '';
  meta.description = "Libre Baskerville";
}
