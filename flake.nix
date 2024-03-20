{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-config = {
      url = "github:pawellendzion/neovim-config";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      constants = import ./constants.nix;
    in
    {
      nixosConfigurations = {
        nixos-vbox = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = inputs // {
            inherit constants;
          };

          modules = [
            ./hosts/nixos-vbox
            ./modules/base
            ./modules/desktop.nix

            { modules.desktop.xorg.enable = true; }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = inputs // {
                  inherit constants;
                  pkgs-stable = import inputs.nixpkgs-stable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${constants.user.name} = {
                  imports = [
                    ./home
                    { modules.desktop.i3.enable = true; }
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
