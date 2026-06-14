{lib, config, pkgs, ... }:

{
    xdg.configFile."foot/gruvbox.ini".source = "${pkgs.foot.themes}/share/foot/themes/gruvbox-dark";
    xdg.configFile."foot/foot.ini" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/user/foot/config/foot.ini";
    };
}
