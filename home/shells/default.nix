{ pkgs, ... }:
let
  scripts = import ./scripts/default.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    direnv
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    bash.enable = true;

    zsh = {
      enable = true;

      shellAliases = {
        fc = ". ${scripts.fzf-cd}/bin/fzf-cd .";
        fh = ". ${scripts.fzf-cd}/bin/fzf-cd ~";
      };

      initExtra = ''
        bindkey '^E' autosuggest-accept
        bindkey '^ ' forward-word
        source <(${pkgs.fzf}/bin/fzf --zsh)
      '';

      localVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = [
          "match_prev_cmd"
          "completion"
        ];
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0";
            hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
          };
        }
      ];
    };
  };

}
