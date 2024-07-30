{ ... }:
let
  hostName = "plendzion";

  system-config = { config, ... }: {
    # Bootloader.
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    networking = {
      inherit hostName;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      firewall.enable = false;

      # Enable networking
      networkmanager.enable = true;

      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    services = {
      xserver.dpi = 96;
      xserver.videoDrivers = [ "nvidia" ];

      # Enable touchpad support (enabled default in most desktopManager).
      # xserver.libinput.enable = true;
    };

    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;

      nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      nvidia.nvidiaSettings = true;
      nvidia.modesetting.enable = true;
    };

    system.stateVersion = "24.05";
  };

  base-modules = {
    nixos = [
      ./hardware-configuration.nix
      ../../modules/base
      ../../modules/desktop.nix
      system-config
    ];

    home = [
      ../../home
      ./home.nix
    ];
  };

  i3-module = {
    nixos = [
      { modules.desktop.xorg.enable = true; }
    ] ++ base-modules.nixos;

    home = [
      {
        alacritty.font-size = 9.25;
        modules.desktop.i3 = {
          enable = true;
          modifier = "Mod4";
          extraConfig = ''
            workspace $ws1 output DVI-D-0
            workspace $ws2 output HDMI-0
            workspace $ws3 output VGA-0
            workspace $ws4 output VGA-0

            exec --no-startup-id i3-msg "workspace $ws1; exec alacritty"
            exec --no-startup-id i3-msg "workspace $ws2; exec google-chrome-stable"
            exec --no-startup-id i3-msg "workspace $ws3; exec dbeaver"
            exec --no-startup-id i3-msg "workspace $ws4; exec mailspring --password-store='gnome-libsecret'"

            assign [class="Alacritty"] $ws1
            assign [class="Google-chrome"] $ws2
            assign [class="DBeaver"] $ws3
            assign [class="Mailspring"] $ws4
          '';
        };
      }
    ] ++ base-modules.home;
  };
in
i3-module
