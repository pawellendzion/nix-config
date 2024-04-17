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
      } // builtins.fromTOML (builtins.readFile "${catppuccin-alacritty}/catppuccin-mocha.toml");
    };
  };
}
