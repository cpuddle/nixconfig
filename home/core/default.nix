{ config, lib, pkgs, ... }:
{
    options.nixconfigDir = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/nixconfig";
    };

    config = {
        home.username = "collin";
        home.homeDirectory = "/home/collin";
        home.stateVersion = "26.05";
        services.polkit-gnome.enable = true;
    };

}
