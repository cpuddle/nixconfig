{lib, config, pkgs, ... }:

{
    home.packages = with pkgs; [
        goimapnotify
    ];

    systemd.user.services.goimapnotify = {
        Unit = {
            Description = "IMAP IDLE notification daemon";
            After = [ "network.target" ];
        };
        Service = {
            ExecStart = "${pkgs.goimapnotify}/bin/goimapnotify -conf %h/.config/goimapnotify/goimapnotify.yaml";
            Restart = "on-failure";
            RestartSec = 5;
            Environment = [
                "GPG_TTY=/dev/pts/0"
                "GNUPGHOME=%h/.gnupg"
            ];
        };
        Install.WantedBy = [ "default.target" ];
    };

    xdg.configFile."goimapnotify/goimapnotify.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/home/goimapnotify/config/goimapnotify.yaml";
    };
}
