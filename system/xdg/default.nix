{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        xdg-user-dirs
        xdg-utils
    ];
    xdg = {
        autostart.enable = true;
        icons.enable = true;
        menus.enable = true;
        sounds.enable = true;
        mime = {
            enable = true;
            defaultApplications = {
                "application/pdf"                   = "zathura.desktop";

                "text/html"                         = "firefox.desktop";
                "x-scheme-handler/http"             = "firefox.desktop";
                "x-scheme-handler/https"            = "firefox.desktop";
                "x-scheme-handler/about"            = "firefox.desktop";
                "x-scheme-handler/unknown"          = "firefox.desktop";
            
                # File manager
                "inode/directory"                   = "thunar.desktop";
            
                # Images
                "image/png"                         = "imv.desktop";
                "image/jpeg"                        = "imv.desktop";
                "image/gif"                         = "imv.desktop";
                "image/webp"                        = "imv.desktop";
                "image/svg+xml"                     = "imv.desktop";
            
                # Video
                "video/mp4"                         = "mpv.desktop";
                "video/mkv"                         = "mpv.desktop";
                "video/webm"                        = "mpv.desktop";
                "video/x-matroska"                  = "mpv.desktop";
            
                # Audio
                "audio/mpeg"                        = "mpv.desktop";
                "audio/flac"                        = "mpv.desktop";
                "audio/ogg"                         = "mpv.desktop";
                "audio/wav"                         = "mpv.desktop";
            
                # Text / code
                "text/plain"                        = "nvim.desktop";
                "text/markdown"                     = "nvim.desktop";
                "text/x-shellscript"                = "nvim.desktop";

                # Archives
                "application/zip"               = "org.gnome.FileRoller.desktop";
                "application/x-tar"             = "org.gnome.FileRoller.desktop";
                "application/x-bzip2"           = "org.gnome.FileRoller.desktop";
                "application/x-gzip"            = "org.gnome.FileRoller.desktop";
                "application/x-xz"              = "org.gnome.FileRoller.desktop";
            };
        };
        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = [ 
                pkgs.xdg-desktop-portal-gtk
                pkgs.xdg-desktop-portal-wlr
            ];
            config = {
                common = {
                    default = [ "wlr" "gtk" ];
                };
            };
        };
    };
}

