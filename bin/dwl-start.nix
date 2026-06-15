{ config, pkgs, ... }:
let
    dwl = config.programs.dwl.package;
in
{
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "dwl-init" ''
             if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
                 . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
             fi

             ${pkgs.swaybg}/bin/swaybg -i $HOME/nixconfig/assets/wallpapers/outer-wilds-4k.png -m fill -o DP-1 &
             export XDG_CURRENT_DESKTOP=sway
             systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
             dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY
             systemctl --user start polkit-gnome-agent
             systemctl --user start xdg-desktop-portal-wlr
             systemctl --user start xdg-desktop-portal
        '')         

        (pkgs.writeShellScriptBin "dwl-start" ''
            exec ${dwl}/bin/dwl -s dwl-init
        '')
    ];
}
