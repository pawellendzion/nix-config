{ pkgs, userName, ... }: {
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_26;
  };

  users.users.${userName} = {
    extraGroups = [ "docker" ];
  };
}
