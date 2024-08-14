{ nixpkgs, ... }@inputs:
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

  configs = (import ../hosts/plendzion (inputs // {
    inherit nixosSystem;
  })).nixosConfigurations;
in
{
  nixosConfigurations = {
    nixos-vbox = nixosSystem (import ../hosts/nixos-vbox inputs);
    # plendzion = nixosSystem (import ../hosts/plendzion inputs);
  } // configs;
}
