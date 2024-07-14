{ lib, ... }: {
  nixosSystemWith = import ./nixosSystemWith.nix;

  getPaths = path:
    builtins.map
      (name: path + "/${name}")
      (builtins.attrNames
        (lib.attrsets.filterAttrs
          (name: type:
            (type == "directory") ||
            (
              name != "default.nix" &&
              (lib.strings.hasSuffix ".nix" name)
            )
          )
          (builtins.readDir path)
        )
      );
}
