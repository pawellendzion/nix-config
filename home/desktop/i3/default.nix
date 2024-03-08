{ ... }: {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1";
      };
      # extraConfig = builtins.readFile ../conf/i3-config;
    };
  };
}
