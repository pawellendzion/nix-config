{ constants, ... }: {
  programs.git = {
    enable = true;

    userName = constants.user.fullName;
    userEmail = constants.user.email;
  };
}
