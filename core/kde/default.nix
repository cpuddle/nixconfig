{ config, lib, pkgs, ... }:
{
    services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
        flatpak.enable = true;
    };

    environment.systemPackages = with pkgs; [
        # KDE applications
        kdePackages.discover          # software center (Flatpak/firmware)
        kdePackages.kcalc             # calculator
        kdePackages.kcharselect       # character map
        kdePackages.kclock            # clock
        kdePackages.kcolorchooser     # color picker
        kdePackages.kolourpaint       # simple paint
        kdePackages.ksystemlog        # system log viewer
        kdePackages.sddm-kcm          # SDDM settings module

        # Disk and hardware tools
        kdePackages.isoimagewriter    # write hybrid ISOs to USB
        kdePackages.partitionmanager  # disk/partition management
        hardinfo2                     # hardware info and benchmarks

        # Wayland
        wayland-utils                 # diagnostics
        wl-clipboard                  # clipboard support

        # Other
        kdiff3                        # file/directory diff
        vlc                           # media player
    ];
}
