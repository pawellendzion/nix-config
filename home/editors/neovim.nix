{ pkgs, neovim-config, ... }: {
  home.packages = with pkgs; [
    xclip
    gnumake
    ripgrep
    nodejs_18

    # Formatters
    nixpkgs-fmt

    # LSPs
    lua-language-server # lua
    nil # Nix
    vscode-langservers-extracted # JSON / HTML / CSS / ESLint
    nodePackages.typescript-language-server
    nodePackages.intelephense

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
