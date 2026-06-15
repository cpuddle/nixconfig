{lib, config, pkgs, ... }:

{
    xdg.configFile."mako" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/user/mako/config";
    };
}
