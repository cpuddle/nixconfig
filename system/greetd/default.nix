{ config, lib, pkgs, ... }:
{
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd dwl";
                user = "greeter";
            };
        };
    };
    programs.dconf.enable = true;
}
