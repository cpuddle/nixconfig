{lib, config, pkgs, ... }:

{
    stylix.targets.kde = {
        enable = true;
        plasmaWorkspacePackage = pkgs.kdePackages.plasma-workspace;
    };
}
