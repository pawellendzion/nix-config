{ config, lib, ... }: with lib; let
  cfgXorg = config.modules.desktop.xorg;
in {
  options.modules.desktop = {
    xorg.enable = mkEnableOption "Xorg display server";
  };

  config = mkIf cfgXorg.enable {
    services = {
      xserver = {
        enable = true;

        displayManager = {
          sddm.enable = true;
          # defaultSession = "hm-session";
        };

        desktopManager = {
          runXdgAutostartIfNone = true;
        };

        xkb = {
          layout = "pl";
          variant = "";
        };
      };
    };
  };
}
