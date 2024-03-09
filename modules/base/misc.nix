{ ... }: {
  boot.loader.systemd-boot = {
    configurationLimit = 10;
  };

  environment.variables.EDITOR = "nvim";

  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
