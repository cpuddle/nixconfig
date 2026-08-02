{ config, pkgs, lib, ... }:
let
    fontconfigOverride = pkgs.writeText "flatpak-fontconfig-defaults.conf" ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
            <alias>
                <family>sans-serif</family>
                <prefer><family>${config.stylix.fonts.sansSerif.name}</family></prefer>
            </alias>
            <alias>
                <family>serif</family>
                <prefer><family>${config.stylix.fonts.serif.name}</family></prefer>
            </alias>
            <alias>
                <family>monospace</family>
                <prefer><family>${config.stylix.fonts.monospace.name}</family></prefer>
            </alias>
        </fontconfig>
    '';

    applyScript = pkgs.writeShellScript "flatpak-apply-fontconfig" ''
        set -euo pipefail
        for base in "$HOME/.local/share/flatpak/app" "/var/lib/flatpak/app"; do
            [ -d "$base" ] || continue
            for appdir in "$base"/*/; do
                id="$(basename "$appdir")"
                confdir="$HOME/.var/app/$id/config/fontconfig/conf.d"
                mkdir -p "$confdir"
                ln -sf "${fontconfigOverride}" "$confdir/50-defaults.conf"
            done
        done
    '';
in
{
    systemd.user.services.flatpak-fontconfig = {
        description = "Apply Stylix fontconfig defaults to installed Flatpak apps";
        wantedBy = [ "default.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${applyScript}";
        };
    };

    systemd.user.paths.flatpak-fontconfig = {
        description = "Re-apply fontconfig defaults when Flatpak apps change";
        wantedBy = [ "paths.target" ];
        pathConfig.PathChanged = [
            "%h/.local/share/flatpak/app"
            "/var/lib/flatpak/app"
        ];
    };
}
