{ pkgs, ... }: {
  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Wallpaper setter";
      After = [ "graphical-session-pre.target" ];
      Wants = [ "graphical-session-pre.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.feh}/bin/feh ${./wallpaper.png} --bg-fill";
    };
  };
}
