{ config, pkgs, ... }:
let
    dwl = config.programs.dwl.package;
in
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "dwl-init" ''
            # Wait for WAYLAND_DISPLAY to be set by dwl
            timeout=20
            while [ -z "$WAYLAND_DISPLAY" ] && [ $timeout -gt 0 ]; do
                sleep 0.5
                timeout=$((timeout - 1))
            done

            systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY DBUS_SESSION_BUS_ADDRESS
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY

            ${pkgs.swaybg}/bin/swaybg -i $HOME/nixconfig/assets/wallpapers/outer-wilds-4k.png -m fill &

            systemctl --user restart polkit-gnome-agent
            systemctl --user restart xdg-desktop-portal-wlr
            systemctl --user restart xdg-desktop-portal
            ${pkgs.gnupg}/bin/gpg --decrypt $HOME/.local/state/mutt_oauth2/collin.gpg > /dev/null 2>&1
            sleep 5
        '')

        (pkgs.writeShellScriptBin "dwl-start" ''
            if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
                . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
            fi

            export XDG_CURRENT_DESKTOP=sway
            export GPG_TTY=$(tty)

            exec dbus-run-session -- ${dwl}/bin/dwl -s dwl-init
        '')
    ];
}
