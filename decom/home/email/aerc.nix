{ lib, config, pkgs, ... }:

let
    cfg = config.myEmail;
    accountName = "m365";
in
{
    config = lib.mkIf cfg.enable {
        programs.aerc = {
            enable = true;
            extraConfig = {
                general.unsafe-accounts-conf = true;
                ui = {
                    sort = "-r date";
                    index-format = "%D %-17.17n %Z %s";
                    tab-title-account = cfg.address;
                };
                filters = {
                    "text/plain" = "colorize";
                    "text/html" = "${pkgs.w3m}/bin/w3m -T text/html -dump -cols 100";
                };
            };
        };

        xdg.configFile."aerc/binds.conf".text =
            builtins.readFile "${pkgs.aerc}/share/aerc/binds.conf"
            + ''

                [messages]
                M = :read -t<Enter>
            '';

        accounts.email.accounts.${accountName}.aerc = {
            enable = true;
            extraAccounts = {
                source = "maildir://${cfg.maildir}";
                outgoing = "smtp+xoauth2://${cfg.address}@smtp.office365.com:587";
                from = "\"${cfg.realName}\" <${cfg.address}>";
                source-cred-cmd = "mutt-oauth2-m365";
                outgoing-cred-cmd = "mutt-oauth2-m365";
                copy-to = "Sent";
            };
        };
    };
}
