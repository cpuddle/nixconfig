{lib, config, pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
	sideloadInitLua = true;
    };

    xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.nixconfigDir}/home/nvim/config";
    };
}
