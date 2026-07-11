{ config, lib, ... }:

{
    networking = {
	hostName = "proxima";
    domain = "frankonet.net";
	firewall.enable = true;
	networkmanager.enable = true;
    };
}
