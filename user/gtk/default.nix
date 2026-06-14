{lib, config, pkgs, ... }:

{
    gtk = {
        gtk3.extraConfig = {
            gtk-decoration-layout = appmenu:none;
        };
        gtk4.extraConfig = {
            gtk-decoration-layout = appmenu:none;
        };
    };
    stylix.targets.gtk = {
        extraCss = ''
            * { font-weight: 600; }
        '';
    };
}
