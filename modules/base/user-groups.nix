{ constants, ... }: {
  # Don't allow mutation of users outside the config.
  # users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${constants.user.name} = {
    isNormalUser = true;
    description = constants.user.fullName;
    extraGroups = [
      constants.user.name
      "networkmanager" 
      "wheel"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
