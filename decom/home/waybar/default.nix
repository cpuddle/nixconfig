{lib, config, pkgs, ... }:

{
    stylix.targets.waybar.enable = false;
    xdg.configFile."waybar" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/home/waybar/config";
    };
}
