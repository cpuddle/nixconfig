{ pkgs, ... }:

{
    config.stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
        polarity = "dark";
        cursor = {
            name = "Capitaine Cursors (Gruvbox)";
            package = pkgs.capitaine-cursors-themed;
            size = 24;
        };
        icons = {
            enable = true;
            package = pkgs.gruvbox-plus-icons;
            dark = "Gruvbox-Plus-Dark";
            light = "Gruvbox-Plus-Light";
        };
        targets = {
            grub.enable = false;
        };
    };
}
