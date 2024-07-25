{ catppuccin-alacritty
, config
, lib
, ...
}:
let
  cfg = config.alacritty;
in
{
  options.alacritty = {
    font-size = lib.mkOption {
      default = null;
    };
  };

  config.programs = {
    alacritty = {
      enable = true;

      settings = {
        font = {
          normal = {
            family = "FantasqueSansM Nerd Font";
            style = "Regular";
          };
        } // (lib.mkIf (cfg.font-size != null) { size = cfg.font-size; });
      } // builtins.fromTOML (builtins.readFile "${catppuccin-alacritty}/catppuccin-mocha.toml");
    };
  };
}
