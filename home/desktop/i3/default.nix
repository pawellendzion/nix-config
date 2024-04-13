{ lib, pkgs, modifier, ... }: {
  home.packages = with pkgs; [
    dmenu
    i3status
    i3lock
    picom
  ];

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = lib.mkForce null;
      extraConfig = ''
        set $mod ${modifier}
        ${builtins.readFile ./conf/i3-config}
      '';
    };
  };
}

