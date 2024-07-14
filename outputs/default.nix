{ self
, nixpkgs
, home-manager
, ...
}@inputs:
let
  system = "x86_64-linux";

  username = "pawellendzion";
  userEmail = "pawellendzion01@gmail.com";
  userFullName = "Paweł Lendzion";

  mylib = import ../lib { inherit (nixpkgs) lib; };

  specialArgs = inputs // {
    inherit username userEmail userFullName mylib;

    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };

  nixosSystem = mylib.nixosSystemWith { inherit inputs specialArgs system username; };
in
{
  nixosConfigurations = {
    nixos-vbox = nixosSystem (import ../hosts/nixos-vbox inputs);

    plendzion = nixpkgs.lib.nixosSystem {
      inherit system specialArgs;

      modules = [
        ../hosts/plendzion
        ../modules/base
        ../modules/desktop.nix

        { modules.desktop.xorg.enable = true; }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = {
              imports = [
                ../home
                ../hosts/plendzion/home.nix
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
}
