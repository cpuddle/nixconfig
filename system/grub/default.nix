{ inputs, lib, config, pkgs, ... }:

{

    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        splashImage = null;
        theme = "${pkgs.shodan-grub-theme}/grub/themes/Shodan";
        font = "${pkgs.nerd-fonts.iosevka-term-slab}/share/fonts/truetype/NerdFonts/IosevkaTermSlab/IosevkaTermSlabNerdFont-Regular.ttf";
        fontSize = 16;
        device = "nodev";
        fsIdentifier = "label";
        useOSProber = true;
        gfxmodeEfi = "2560x1440";
        gfxpayloadBios = "text";
    };
    boot.loader.efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
    };

}
