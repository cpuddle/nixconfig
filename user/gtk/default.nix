{lib, config, pkgs, ... }:

{
    stylix.targets.gtk = {
        extraCss = ''
            gtk-decoration-layout = appmenu:none
            * { font-weight: bold; }
        '';
    };
}
