{ nixosSystem, ... }:
let
  hostName = "plendzion";

  system-config = { config, pkgs, ... }: {
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

    # boot.kernelModules = [ "nouveau" ];
    # boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

    services = {
      xserver.dpi = 96;
      xserver.videoDrivers = [ "nvidia" ];
      # xserver.videoDrivers = [ "nouveau" ];

      # Enable touchpad support (enabled default in most desktopManager).
      # xserver.libinput.enable = true;
    };

    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
      # graphics.extraPackages = with pkgs; [
      #   mesa
      #   mesa.drivers
      # ];

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

  hyprland-module = {
    nixos = [
      {
        services.displayManager.sddm.enable = true;
        services.displayManager.sddm.wayland.enable = true;
        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
        };
      }
    ] ++ base-modules.nixos;

    home = [
      {
        alacritty.font-size = 9.25;
        wayland.windowManager.hyprland = {
          enable = true;
          xwayland.enable = true;
          systemd.enable = true;
          settings = {
            "$mod" = "SUPER";
            bind =
              [
                "$mod, Q, exec, alacritty"
                "$mod, F, exec, firefox"
                ", Print, exec, grimblast copy area"
              ];
            # ++ (
            #   # workspaces
            #   # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            #   builtins.concatLists (builtins.genList
            #     (
            #       x:
            #       let
            #         ws =
            #           let
            #             c = (x + 1) / 10;
            #           in
            #           builtins.toString (x + 1 - (c * 10));
            #       in
            #       [
            #         "$mod, ${ws}, workspace, ${toString (x + 1)}"
            #         "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            #       ]
            #     )
            #     10)
            # );
          };
        };
      }
    ] ++ base-modules.home;
  };
in
{
  nixosConfigurations = {
    "${hostName}-i3" = nixosSystem i3-module;
    "${hostName}-hyprland" = nixosSystem hyprland-module;
  };
}
# hyprland-module
# i3-module
