{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    git
    neovim
    neofetch
    btop
    pciutils
    usbutils
  ];
}
