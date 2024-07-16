{ catppuccin-alacritty, ... }: {
  programs = {
    alacritty = {
      enable = true;

      settings = {
        window.opacity = 0.97;

        font = {
          normal = {
            family = "FantasqueSansM Nerd Font";
            style = "Regular";
          };
          size = 10.25;
        };
      } // builtins.fromTOML (builtins.readFile "${catppuccin-alacritty}/catppuccin-mocha.toml");
    };
  };
}
