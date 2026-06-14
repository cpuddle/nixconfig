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
        targets = {
            grub.enable = false;
        };
    };
}
