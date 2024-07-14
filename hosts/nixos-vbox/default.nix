{ ... }:
let
  hostName = "nixos-vbox";

  base-config = {
    # Bootloader.
    boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };

    networking = {
      inherit hostName;
      firewall.enable = false;

      # Enable networking
      networkmanager.enable = true;

      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    virtualisation.virtualbox.guest = {
      enable = true;
    };

    system.stateVersion = "24.05";
  };

  base-modules = {
    nixos = [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/desktop.nix
      base-config
    ];

    home = [
      ../../home
      ./home.nix
    ];
  };

  i3-modules = {
    nixos = [
      { modules.desktop.xorg.enable = true; }
    ] ++ base-modules.nixos;

    home = [
      {
        modules.desktop.i3 = {
          enable = true;
          modifier = "Mod1";
        };
      }
    ] ++ base-modules.home;
  };
in
i3-modules

