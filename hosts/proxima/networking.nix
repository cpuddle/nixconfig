{ config, lib, ... }:

{
    networking = {
	hostName = "proxima";
	firewall.enable = true;
	networkmanager.enable = true;
    };
}
