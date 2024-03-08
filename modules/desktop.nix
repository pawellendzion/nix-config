{ config, lib, pkgs, ... }: with lib; let
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
          lightdm.enable =  true;
          defaultSession = "hm-session";
          # session = [
          #   {
          #     name = "hm-session";
          #     manage = "window";
          #     start = ''
          #       ${pkgs.runtimeShell} $HOME/.xsession &
          #       waitPID=$!
          #     '';
          #   }
          # ];
        };

        desktopManager = {
          runXdgAutostartIfNone = true;
          session = [
            {
              name = "hm-session";
              manage = "window";
              start = ''
                ${pkgs.runtimeShell} $HOME/.xsession &
                waitPID=$!
              '';
            }
          ];
        };

        xkb = {
          layout = "pl";
          variant = "";
        };
      };
    };
  };
}
