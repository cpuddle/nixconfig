{lib, config, pkgs, ... }:

{
    home.packages = with pkgs; [
        mpc
        snapcast
        rmpc
    ];

    systemd.user.services.snapclient = {
        Unit = {
            Description = "Snapcast client";
            After = "network.target sound.target";
        };
        Service = {
            ExecStart = "${pkgs.snapcast}/bin/snapclient -h 10.150.1.2";
            Restart = "always";
            RestartSec = 5;
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
    };

    xdg.configFile."rmpc/config.ron" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/user/mpv/config/config.ron";
    };
}
