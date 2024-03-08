{ pkgs, ... }: {
  systemd.user.services.wallpaper = {
    wantedBy = ["graphical-session.target"];
    unitConfig = {
      Description = "Wallpaper loader";
      After = ["graphical-session-pre.target"];
      Wants = ["graphical-session-pre.target"];
    };
    script = "${pkgs.feh}";
  };
}
