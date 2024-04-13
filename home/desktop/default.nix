{ config, lib, pkgs, ... }@args:
with lib;
let
  cfg = config.modules.desktop.i3;
in
{
  options.modules.desktop.i3 = {
    enable = mkEnableOption "i3 window manager";
    modifier = mkOption {
      default = "Mod4";
    };
  };

  config = mkIf cfg.enable (import ./i3 (args // { modifier = cfg.modifier; }));
}
