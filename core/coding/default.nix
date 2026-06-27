{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        python3
    ];

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };
}
