{ constants, ... }: {
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  users.users.${constants.user.name} = {
    isNormalUser = true;
    description = constants.user.fullName;
    extraGroups = [
      constants.user.name
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
