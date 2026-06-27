{ config, lib, pkgs, ... }:
{
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "cpuddle";
                email = "collin@collinfranklin.com";
            };
        };
    };
}
