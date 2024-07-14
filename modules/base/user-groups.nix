{ username, userFullName, ... }: {
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  users.users.${username} = {
    isNormalUser = true;
    description = userFullName;
    extraGroups = [
      username
      "networkmanager"
      "wheel"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
