{ lib, config, ... }:

{
    imports = [
        ./oauth2.nix
        ./mbsync.nix
        ./aerc.nix
        ./notify.nix
        ./imapnotify.nix
    ];

    options.myEmail = {
        enable = lib.mkEnableOption "email stack: mbsync + aerc + oauth2 + notifications";

        address = lib.mkOption {
            type = lib.types.str;
            default = "collin@collinfranklin.com";
        };

        realName = lib.mkOption {
            type = lib.types.str;
            default = "Collin";
        };

        maildir = lib.mkOption {
            type = lib.types.str;
            default = "${config.home.homeDirectory}/Mail";
        };

        pollIntervalSeconds = lib.mkOption {
            type = lib.types.int;
            default = 30;
        };
        fallbackSyncMinutes = lib.mkOption {
            type = lib.types.int;
            default = 1;
        };
        oauth2 = {
            tenant = lib.mkOption {
                type = lib.types.str;
                default = "common";
            };

            tokenFile = lib.mkOption {
                type = lib.types.str;
                default = "${config.xdg.stateHome}/email/ms-token.gpg";
            };
            tokenCommand = lib.mkOption {
                type = lib.types.package;
            };
        };
    };

    config = {
        myEmail.enable = true;

        accounts.email.maildirBasePath = lib.mkIf config.myEmail.enable (
            lib.mkDefault config.myEmail.maildir
        );
    };
}
