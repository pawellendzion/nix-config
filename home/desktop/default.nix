{ config, lib, pkgs, ... }@args:
with lib;
let
  i3Cfg = config.modules.desktop.i3;
  wallpaper = config.modules.desktop.wallpaper;
  monitor-setup-script = config.modules.desktop.monitor-setup-script;
in
{
  options.modules.desktop = {
    wallpaper = mkOption { };
    monitor-setup-script = mkOption { };

    i3 = {
      enable = mkEnableOption "i3 window manager";
      modifier = mkOption {
        default = "Mod4";
      };
      extraConfig = mkOption {
        default = "";
      };
    };
  };

  config = mkIf i3Cfg.enable (mkMerge [
    {
      xsession.initExtra = ''
        ${pkgs.picom}/bin/picom --config ${./picom/conf/picom.conf} -b
        ${monitor-setup-script}
        ${pkgs.feh}/bin/feh ${wallpaper} --bg-fill
      '';
    }
    (import ./i3 (args // { inherit (i3Cfg) modifier extraConfig; }))
  ]);
}
