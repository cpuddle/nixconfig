{ pkgs, ... }:
let
  sans = import ./sans { inherit pkgs; };
  serif = import ./serif { inherit pkgs; };
  mono = import ./monospace { inherit pkgs; };
in

{
    fonts.packages = sans ++ serif ++ mono;

    fonts.fontconfig.defaultFonts = {
        sansSerif = [ "IBM Plex Sans Condensed" ];
        monospace = [ "Iosevka Term Slab Nerd Font"];
        serif = [ "Libre Baskerville" ];
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
            name = "Iosevka Term Slab Nerd Font";
        };
        sizes = {
            applications = 9;
            desktop = 9;
            popups = 9;
            terminal = 9;
        };
    };
}
