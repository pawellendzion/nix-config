{ lib, pkgs, ... }: {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = lib.mkForce null;
      extraConfig = builtins.readFile ./conf/i3-config;
    };
  };

  home.packages = with pkgs; [
    dmenu
    i3status
    i3lock
    picom
  ];
}
