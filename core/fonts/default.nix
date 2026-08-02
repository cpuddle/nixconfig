{ config, pkgs, ... }:
let
    sans = import ./sans { inherit pkgs; };
    serif = import ./serif { inherit pkgs; };
    mono = import ./monospace { inherit pkgs; };

    aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
    };

    mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
in
{
#    imports = [ ./flatpak-fonts.nix ];
    fonts = {
        packages = sans ++ serif ++ mono;
        fontconfig = {
            enable = true;
            defaultFonts = {
                sansSerif = [ "IBM Plex Sans Condensed" ];
                monospace = [ "Iosevka Nerd Font"];
                serif = [ "Libre Baskerville" ];
            };
            antialias = true;
            hinting = {
                enable = true;
                style = "medium";       
            };
            subpixel = {
                rgba = "rgb";      # match your monitor layout
                lcdfilter = "default";
            };
        };
    };

    stylix.fonts = {
        serif = {
            package = builtins.head serif;
            name = "Libre Baskerville";
        };
        sansSerif = {
            package = builtins.head sans;
            name = "IBM Plex Sans Condensed";
        };
        monospace = {
            package = builtins.head mono;
            name = "Iosevka Nerd Font";
        };
        sizes = {
            applications = 9;
            desktop = 9;
            popups = 9;
            terminal = 9;
        };
    };

    system.fsPackages = [ pkgs.bindfs ];

    fileSystems."/usr/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
}
