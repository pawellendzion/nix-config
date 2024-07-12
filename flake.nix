{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };

    catppuccin-tmux = {
      url = "github:catppuccin/tmux";
      flake = false;
    };

    neovim-config = {
      url = "github:pawellendzion/neovim-config";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      userName = "pawellendzion";
      userEmail = "pawellendzion01@gmail.com";
      userFullName = "Paweł Lendzion";
    in
    {
      nixosConfigurations = {
        nixos-vbox = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = inputs // {
            inherit userName userEmail userFullName;

            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };

            pkgs-stable = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
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
                  inherit userName userEmail userFullName;

                  pkgs = import inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                  };

                  pkgs-stable = import inputs.nixpkgs-stable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${userName} = {
                  imports = [
                    ./home
                    ./hosts/nixos-vbox/home.nix
                    {
                      modules.desktop.i3 = {
                        enable = true;
                        modifier = "Mod1";
                      };
                    }
                  ];
                };
              };
            }
          ];
        };

        plendzion = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = inputs // {
            inherit userName userEmail userFullName;

            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };

            pkgs-stable = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          };

          modules = [
            ./hosts/plendzion
            ./modules/base
            ./modules/desktop.nix

            { modules.desktop.xorg.enable = true; }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = inputs // {
                  inherit userName userEmail userFullName;

                  pkgs = import inputs.nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true;
                  };

                  pkgs-stable = import inputs.nixpkgs-stable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${userName} = {
                  imports = [
                    ./home
                    ./hosts/plendzion/home.nix
                    {
                      modules.desktop.i3 = {
                        enable = true;
                        modifier = "Mod4";
                        extraConfig = ''
                          workspace $ws1 output DVI-D-1
                          workspace $ws2 output HDMI-1
                          workspace $ws3 output VGA-1
                          workspace $ws4 output VGA-1

                          exec --no-startup-id i3-msg "workspace $ws1; exec alacritty"
                          exec --no-startup-id i3-msg "workspace $ws2; exec google-chrome-stable"
                          exec --no-startup-id i3-msg "workspace $ws3; exec dbeaver"
                          exec --no-startup-id i3-msg "workspace $ws4; exec mailspring --password-store='gnome-libsecret'"

                          assign [class="Alacritty"] $ws1
                          assign [class="Google-chrome"] $ws2
                          assign [class="DBeaver"] $ws3
                          assign [class="Mailspring"] $ws4
                        '';
                      };
                    }
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
