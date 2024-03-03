{ pkgs, ... }: {
  home.packages = with pkgs; [
    xclip
    gnumake

    # LSP
    lua-language-server # lua
    nil # Nix
    vscode-langservers-extracted # JSON / HTML / CSS / ESLint

    # DAP
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
      source = ./conf;
      recursive = true;
    };
  };
}
