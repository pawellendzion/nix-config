{ config, lib, ... }@args: with lib; let 
  cfg = config.modules.desktop.i3;
in {
  options.modules.desktop.i3 = {
    enable = mkEnableOption "i3 window manager";
  };

  config = mkIf cfg.enable (import ./i3 args);
}
