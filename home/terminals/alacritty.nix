{ catppuccin-alacritty, ... }: {
  programs = {
    alacritty = {
      enable = true;

      settings = {
        window.opacity = 0.97;

        font.normal = {
          family = "FantasqueSansM Nerd Font";
          style = "Regular";
        };

        env.TERM = "xterm-256color";
      } // builtins.fromTOML (builtins.readFile "${catppuccin-alacritty}/catppuccin-mocha.toml");
    };
  };
}
