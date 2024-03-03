{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    constants = import ./constants.nix;
  in {
    nixosConfigurations = {
      nixos-vbox = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./modules/base
          ./hosts/nixos-vbox

          {
            _module.args = { 
              inherit constants;
              inherit (inputs) nixpkgs;
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager = {   
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
                inherit constants;
                pkgs-stable = import inputs.nixpkgs-stable {
                  inherit system; 
                  config.allowUnfree = true;
                };
              };
              users.${constants.user.name} = import ./home;
            };
          }
        ];
      };
    };
  };
}
