{ userFullName, userEmail, ... }: {
  programs.git = {
    enable = true;

    userName = userFullName;
    inherit userEmail;
  };
}
