{ config, lib, pkgs, ... }@args:
with lib;
let
  i3Cfg = config.modules.desktop.i3;
in
{
  options.modules.desktop.i3 = {
    enable = mkEnableOption "i3 window manager";
    modifier = mkOption {
      default = "Mod4";
    };
  };

  config = mkIf i3Cfg.enable (mkMerge [
    (import ./i3 (args // { modifier = i3Cfg.modifier; }))
    (import ./picom args)
  ]);
}
