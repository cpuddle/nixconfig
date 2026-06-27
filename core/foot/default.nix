{ config, lib, pkgs, ... }:
{
    programs.foot = {
        enable = true;
        enableZshIntegration = true;
        xdg.serverAutostart = true;
    };
}
