{ inputs
, specialArgs
, system
, username
}:
modules:
let
  inherit (inputs) nixpkgs home-manager;
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;

  modules = modules.nixos ++ [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users.${username}.imports = modules.home;
    }
  ];
}
