{
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot = {
    configurationLimit = 10;
  };

  environment.variables.EDITOR = "nvim";
}
