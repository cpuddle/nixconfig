{ lib, config, pkgs, ... }:

let
    cfg = config.myEmail;
    accountName = "m365";
in
{
    config = lib.mkIf cfg.enable {
        services.imapnotify.enable = true;

        accounts.email.accounts.${accountName}.imapnotify = {
            enable = true;
            boxes = [ "INBOX" ];
            onNotify = "${pkgs.systemd}/bin/systemctl --user start mbsync.service";
            extraConfig = {
                xoAuth2 = true;
                passwordCmd = "${cfg.oauth2.tokenCommand}/bin/mutt-oauth2-m365";
            };
        };
    };
}
