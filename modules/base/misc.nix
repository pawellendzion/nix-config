{ ... }: {
  boot.loader.systemd-boot = {
    configurationLimit = 10;
  };

  environment.variables.EDITOR = "nvim";
  environment.etc.hosts.mode = "0644";

  # Configure console keymap
  console.keyMap = "pl2";

  services.gnome.gnome-keyring.enable = true;
}
