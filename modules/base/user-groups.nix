{ userName, userFullName, ... }: {
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  users.users.${userName} = {
    isNormalUser = true;
    description = userFullName;
    extraGroups = [
      userName
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
