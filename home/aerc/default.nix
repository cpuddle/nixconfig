{lib, config, pkgs, ... }:

{
    home.packages = with pkgs; [
        aerc
        neomutt
        libnotify
    ];

    xdg.configFile."aerc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/home/aerc/config/";
    };

    home.sessionVariables = {
        GPG_TTY = "$(tty)";
    };
}
