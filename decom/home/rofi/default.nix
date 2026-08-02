{lib, config, pkgs, ... }:

{
    programs.rofi = {
        enable = true;
        terminal = "\${pkgs.foot}/bin/foot";
        font = "IosevkaTermSlab Nerd Font Mono 14";
        extraConfig = {
            modi = "window,combi,ssh,drun,run,keys";
            width = 800;
            lines = 10;
            columns = 2;
            show-icons = true;
            icon-theme = "papirus";
            display-drun = "App";
        };
    };
    stylix.targets.rofi.fonts.enable = false;
    
}
