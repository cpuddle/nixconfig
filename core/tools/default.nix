{ config, lib, pkgs, ... }:

{
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
        python3
        cisco-packet-tracer_9
        gns3-gui
        gns3-server
        traceroute
        tcpdump
        wireguard-tools
    ];
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };
}
