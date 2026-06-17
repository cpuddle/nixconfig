{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "screenshot" ''
            file=$(xdg-user-dir PICTURES)/Screenshots/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')
            slurp | grim -g - "$file" && wl-copy < "$file"
        '')
    ];
}
