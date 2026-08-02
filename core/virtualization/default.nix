{ config, pkgs, ... }:

{
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;      
        };
    };

    programs.virt-manager.enable = true;

    # Add yourself to libvirtd group
    users.users.collin.extraGroups = [ "libvirtd" "kvm" ];
}
