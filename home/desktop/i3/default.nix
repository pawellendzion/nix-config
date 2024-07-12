{ lib
, pkgs
, modifier
, extraConfig
, ...
}: {
  home.packages = with pkgs; [
    dmenu
    i3status
    i3lock
  ];

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = lib.mkForce null;
      extraConfig = ''
        set $mod ${modifier}
        ${builtins.readFile ./conf/i3-config}
        ${extraConfig}
      '';
    };
  };
}

