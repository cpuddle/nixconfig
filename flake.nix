{
    description = "NixOS";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-26.05";
	    home-manager = {
	        url = "github:nix-community/home-manager/release-26.05";
	        inputs.nixpkgs.follows = "nixpkgs";
	    };
        stylix = {
            url = "github:nix-community/stylix/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, stylix, sops-nix, ... }: {
        nixosConfigurations.proxima = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
	        modules = [
		        ./configuration.nix
		        home-manager.nixosModules.home-manager 
                {
		             home-manager = {
			         useGlobalPkgs = true;
			         useUserPackages = true;
			         users.collin = import ./user;
			         backupFileExtension = "backup";
		            };
		        }
                stylix.nixosModules.stylix
                sops-nix.nixosModules.sops
                {
                    nixpkgs.overlays = [ 
                        (import ./overlays { inherit inputs; lib = nixpkgs.lib; }).default 
                    ];
                }
	        ];
	    };
    };
}
