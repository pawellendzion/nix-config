{ pkgs, ... }: {
  home.packages = with pkgs; [
    direnv
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
}
