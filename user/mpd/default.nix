{lib, config, pkgs, ... }:

{
    home.packages = with pkgs; [
        mpc
    ];

    systemd.user.services.mpv-stream = {
        Unit = {
            Description = "MPV MPD stream";
            After = "network.target";
        };
        Service = {
            ExecStart = "${pkgs.mpv}/bin/mpv --no-video http://10.150.1.2:8880";
            Restart = "always";
            RestartSec = 10;
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
    };

    programs.ncmpcpp = {
	    enable = true;
        settings = {
            mpd_host = "media-server";
            mpd_port = 6660;
        };
    };
}
