{ pkgs, neovim-config, ... }: {
  home.packages = with pkgs; [
    xclip
    gnumake
    ripgrep

    # Formatters
    nixpkgs-fmt

    # LSPs
    lua-language-server # lua
    nil # Nix
    vscode-langservers-extracted # JSON / HTML / CSS / ESLint

    # DAPs
  ];

  programs = {
    neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  home.file = {
    ".config/nvim" = {
      source = neovim-config;
      recursive = true;
    };
  };
}
