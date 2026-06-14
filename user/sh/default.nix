{lib, config, pkgs, ... }:

{
    home ={
        packages = with pkgs; [
            fastfetch
        ];
        sessionVariables = {};
    };
    programs = {
        bash = {
            enable = true;
            enableCompletion = true;
            shellAliases = {
                "la" = "ls -lA";
                "ll" = "ls -ll";
                "ff" = "fastfetch";
                "rebuild" = "sudo nixos-rebuild switch --flake '.?submodules=1'";
            };
        };
        starship = {
            enable = true;
            enableBashIntegration = true;
        };
    };
}
