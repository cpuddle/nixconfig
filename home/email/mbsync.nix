{ lib, config, pkgs, ... }:

let
    cfg = config.myEmail;
    accountName = "m365";
    mbsyncWrapped = pkgs.symlinkJoin {
        name = "isync-with-xoauth2";
        paths = [ pkgs.isync ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
            wrapProgram $out/bin/mbsync \
                --set SASL_PATH ${pkgs.cyrus-sasl-xoauth2}/lib/sasl2
        '';
    };
in
{
    config = lib.mkIf cfg.enable {
        programs.mbsync.enable = true;
        programs.mbsync.package = mbsyncWrapped;
        home.packages = [ pkgs.w3m ];
        home.file."${cfg.maildir}/.keep".text = "";
        accounts.email.accounts.${accountName} = {
            primary = true;
            address = cfg.address;
            realName = cfg.realName;
            userName = cfg.address;
            flavor = "outlook.office365.com";
            passwordCommand = "mutt-oauth2-m365";

            mbsync = {
                enable = true;
                create = "both";
                expunge = "both";
                patterns = [ "*" "!Calendar" "!Contacts" "!Tasks" "!Journal" "!Notes" ];
                extraConfig.account = {
                    AuthMechs = "XOAUTH2";
                    PassCmd = "\"mutt-oauth2-m365\"";
                };
            };

            maildir.path = ".";
        };
        services.mbsync = {
            enable = true;
            package = mbsyncWrapped;
            frequency = "*-*-* *:0/${toString cfg.fallbackSyncMinutes}:00";
        };
    };
}
