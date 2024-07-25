{ lib
, pkgs
, modifier
, extraConfig
, ...
}:
let
  polybar-script = pkgs.writeShellScriptBin "polybar-launch" ''
    ${pkgs.killall}/bin/killall -q .polybar-wrappe

    while pgrep -x .polybar-wrappe >/dev/null; do sleep 1; done

    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --config=${../polybar/conf/config.ini} &
      done
    else
      polybar --config=${../polybar/conf/config.ini} &
    fi
    
  '';
in
{
  home.packages = with pkgs; [
    rofi
    i3status
    xss-lock
    (polybar.override { i3Support = true; pulseSupport = true; })
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
        exec_always --no-startup-id ${polybar-script}/bin/polybar-launch &
      '';
    };
  };
}

