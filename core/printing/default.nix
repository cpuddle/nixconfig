{ config, lib, pkgs, ... }: {

    environment.systemPackages = with pkgs; [
        sane-backends
        naps2
    ];

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    services.printing = {
        enable = true;
        drivers = with pkgs; [
            cnijfilter2
            gutenprint
            gutenprintBin
            cups-filters
            cups-browsed
        ];
    };

    hardware.sane.enable = true;
    hardware.sane.openFirewall = true;

    hardware.sane.backends-package = pkgs.sane-backends.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
            echo "mfnp://10.150.3.5" >> $out/etc/sane.d/pixma.conf
        '';
    });

    users.users.collin.extraGroups = [ "scanner" "lp" ];
}
