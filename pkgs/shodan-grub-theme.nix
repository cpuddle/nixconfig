{ stdenv, unzip }:

stdenv.mkDerivation {
    pname = "shodan-grub-theme";
    version = "0.0.1";
    src = ../assets/shodan-grub-theme/Shodan.zip;
    nativeBuildInputs = [ unzip ];
    dontBuild = true;
    installPhase = ''
        runHook preInstall
        mkdir -p $out/grub/themes/Shodan
        cp -r ./* $out/grub/themes/Shodan
        runHook postInstall
    '';
}
