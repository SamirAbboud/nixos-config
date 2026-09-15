{ _config, _lib, pkgs, ... }:

{
  # ===========================================================================
  # IMPORTS & STATE VERSION
  # ===========================================================================
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;

  # ===========================================================================
  # BOOT & KERNEL CONFIGURATION
  # ===========================================================================
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Btrfs Subvolume Options
  fileSystems."/".options = [ "subvol=@" "compress=zstd" ];
  fileSystems."/home".options = [ "subvol=@home" "compress=zstd" ];
  fileSystems."/nix".options = [ "subvol=@nix" "compress=zstd" ];

  zramSwap.enable = true;

  # ===========================================================================
  # HARDWARE & POWER MANAGEMENT
  # ===========================================================================
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };

  services.power-profiles-daemon.enable = true;

  # Custom Lenovo Conservation Mode Service
  systemd.services.lenovo-conservation-mode = {
    description = "Enable Lenovo battery conservation mode";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'";
      RemainAfterExit = true;
    };
  };

  # ===========================================================================
  # NETWORKING & LOCALE
  # ===========================================================================
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Africa/Algiers";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # ===========================================================================
  # USER ACCOUNTS & SHELL
  # ===========================================================================
  programs.fish.enable = true;

  users.users.samir = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  security.sudo.wheelNeedsPassword = true;

  # ===========================================================================
  # DESKTOP ENVIRONMENT, DISPLAY & SERVICES
  # ===========================================================================
  programs.hyprland.enable = true;
  programs.dconf.enable = true;

  # Enable GVfs for Thunar (Trash, Remote Mounts, USB drives)
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # XDG Desktop Portal (Required on Wayland for GTK/Thunar file dialogues)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Display Manager (Ly Greeter)
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clear_password = true;
      default_session = "hyprland";
    };
  };

  # Audio (PipeWire)
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # System Services
  services.openssh.enable = true;
  security.polkit.enable = true;

  # Environment Session Variables
  environment.sessionVariables.GSETTINGS_SCHEMA_DIR =
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";

  # ===========================================================================
  # USER SYSTEMD SERVICES
  # ===========================================================================
  systemd.user.services = {
    # MPRIS Media Controller Daemon
    playerctld = {
      description = "Keep track of active MPRIS media players";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.playerctl}/bin/playerctld";
        Restart = "on-failure";
      };
    };

    # Gnome Polkit Authentication Agent
    polkit-gnome = {
      description = "Polkit GNOME Authentication Agent";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
  };

  # ===========================================================================
  # FONTS CONFIGURATION
  # ===========================================================================
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
      freefont_ttf
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [ "Noto Sans" "Noto Kufi Arabic" ];
        serif     = [ "Noto Serif" "FreeSerif" ];
        monospace = [ "Noto Sans Mono" "FreeMono" ];
      };

      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>ar</string>
            </test>
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Kufi Arabic</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };

  # ===========================================================================
  # PACKAGES & NIX STORE MANAGEMENT
  # ===========================================================================
  environment.systemPackages = with pkgs; [
    git
    vim-full
    wget
    curl
    htop
    pciutils
  ];

  # Nix Daemon Settings & Maintenance
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
