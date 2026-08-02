{ lib, config, pkgs, ... }:

let
    cfg = config.myEmail;
    mutt_oauth2 = pkgs.stdenv.mkDerivation {
        pname = "mutt-oauth2";
        version = "unstable";
        src = ./mutt_oauth2.py;
        dontUnpack = true;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        installPhase = ''
            install -Dm755 $src $out/bin/mutt_oauth2.py
            patchShebangs $out/bin/mutt_oauth2.py
            wrapProgram $out/bin/mutt_oauth2.py \
                --prefix PATH : ${lib.makeBinPath [ pkgs.gnupg pkgs.python3 ]}
        '';
    };

    mutt_oauth2_wrapped = pkgs.writeShellApplication {
        name = "mutt-oauth2-wrapped";
        runtimeInputs = [ pkgs.coreutils ];
        text = ''
            MS_CLIENT_ID="$(cat /run/secrets/email-ms-client-id)"
            MS_CLIENT_SECRET="$(cat /run/secrets/email-ms-client-secret)"
            export MS_CLIENT_ID MS_CLIENT_SECRET
            exec ${mutt_oauth2}/bin/mutt_oauth2.py "$@"
        '';
    };
    mutt_oauth2_m365 = pkgs.writeShellApplication {
        name = "mutt-oauth2-m365";
        text = ''
            exec ${mutt_oauth2_wrapped}/bin/mutt-oauth2-wrapped ${cfg.oauth2.tokenFile}
        '';
    };
in
{
    config = lib.mkIf cfg.enable {
        myEmail.oauth2.tokenCommand = mutt_oauth2_m365;

        home.packages = [ mutt_oauth2 mutt_oauth2_wrapped mutt_oauth2_m365 pkgs.gnupg ];

        home.activation.emailOauth2Dir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$(dirname ${cfg.oauth2.tokenFile})"
        '';
    };
}

