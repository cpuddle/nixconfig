{ config, lib, pkgs, ... }:
{
    programs.git = {
        enable = true;
        userName = "cpuddle";
        userEmail = "collin@collinfranklin.com";
    };
}
